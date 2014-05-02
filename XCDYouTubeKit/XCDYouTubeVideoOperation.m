//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoOperation.h"

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"

static BOOL IsJavaScriptCoreAvailable()
{
	NSURL *javaScriptCoreFrameworkURL = [NSURL fileURLWithPath:@"/System/Library/Frameworks/JavaScriptCore.framework"];
	NSBundle *javaScriptCoreFramework = [NSBundle bundleWithURL:javaScriptCoreFrameworkURL];
	BOOL isJavaScriptCoreAvailable = [javaScriptCoreFramework isLoaded];
	if (!isJavaScriptCoreAvailable)
	{
		NSError *loadError = nil;
		isJavaScriptCoreAvailable = [javaScriptCoreFramework loadAndReturnError:&loadError] && NSClassFromString(@"JSContext");
	}
	return isJavaScriptCoreAvailable;
}

@interface XCDYouTubeVideoOperation () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (atomic, copy, readonly) NSString *videoIdentifier;
@property (atomic, copy, readonly) NSString *languageIdentifier;

@property (atomic, strong) NSURLConnection *connection;
@property (atomic, strong) NSURLResponse *response;
@property (atomic, strong) NSMutableData *connectionData;
@property (atomic, strong) NSMutableArray *eventLabels;

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@property (atomic, strong, readwrite) NSDictionary *info;
@property (atomic, strong, readwrite) NSError *lastError;
@property (atomic, strong, readwrite) NSError *youTubeError; // Error actually coming from the YouTube API, i.e. explicit and localized error

@property (atomic, strong, readwrite) NSError *error;
@property (atomic, strong, readwrite) XCDYouTubeVideo *video;
@end

@implementation XCDYouTubeVideoOperation

- (instancetype) init
{
	@throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithVideoIdentifier:languageIdentifier:` method instead." userInfo:nil];
}

- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier
{
	if (!(self = [super init]))
		return nil;
	
	_videoIdentifier = videoIdentifier ?: @"";
	_languageIdentifier = languageIdentifier ?: @"en";
	
	return self;
}

- (void) startNextVideoInfoRequest
{
	if (self.eventLabels.count == 0)
	{
		[self finishWithError:self.youTubeError ?: self.lastError];
	}
	else
	{
		NSString *eventLabel = [self.eventLabels objectAtIndex:0];
		[self.eventLabels removeObjectAtIndex:0];
		if (eventLabel.length > 0)
			eventLabel = [@"&el=" stringByAppendingString:eventLabel];
		
		NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=%@", self.videoIdentifier, eventLabel, self.languageIdentifier]];
		[self startRequestWithURL:videoInfoURL];
	}
}

- (void) startRequestWithURL:(NSURL *)url
{
	if ([self isCancelled])
		return;
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:self.languageIdentifier forHTTPHeaderField:@"Accept-Language"];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
	[connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
	[connection start];
	self.connection = connection;
}

- (void) handleVideoInfoResponseWithInfo:(NSDictionary *)info signatureFunction:(JSValue *)signatureFunction
{
	NSError *error = nil;
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:self.videoIdentifier info:info signatureFunction:signatureFunction response:self.response error:&error];
	if (video)
	{
		[self finishWithVideo:video];
	}
	else
	{
		if (error.code == XCDYouTubeErrorUseCipherSignature && IsJavaScriptCoreAvailable())
		{
			NSURL *webpageURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@&gl=US&hl=%@&has_verified=1", self.videoIdentifier, self.languageIdentifier]];
			[self startRequestWithURL:webpageURL];
		}
		else
		{
			self.lastError = error;
			if (error.code > 0)
				self.youTubeError = error;
			
			[self startNextVideoInfoRequest];
		}
	}
}

- (void) handleWebPageResponse
{
	__block NSURL *javaScriptPlayerURL = nil;
	CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)self.response.textEncodingName ?: CFSTR(""));
	NSString *html = CFBridgingRelease(CFStringCreateWithBytes(kCFAllocatorDefault, [self.connectionData bytes], (CFIndex)[self.connectionData length], encoding != kCFStringEncodingInvalidId ? encoding : kCFStringEncodingISOLatin1, false));
	NSRegularExpression *playerConfigRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"ytplayer.config\\s*=\\s*(\\{.*?\\});" options:NSRegularExpressionCaseInsensitive error:NULL];
	[playerConfigRegularExpression enumerateMatchesInString:html options:(NSMatchingOptions)0 range:NSMakeRange(0, html.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		NSString *configString = [html substringWithRange:[result rangeAtIndex:1]];
		NSDictionary *playerConfiguration = [NSJSONSerialization JSONObjectWithData:[configString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingOptions)0 error:NULL];
		if ([playerConfiguration isKindOfClass:[NSDictionary class]])
		{
			NSDictionary *args = playerConfiguration[@"args"];
			if ([args isKindOfClass:[NSDictionary class]])
			{
				self.info = args;
				NSString *assets = [playerConfiguration valueForKeyPath:@"assets.js"];
				if ([assets isKindOfClass:[NSString class]])
				{
					NSString *javaScriptPlayerURLString = assets;
					if ([assets hasPrefix:@"//"])
						javaScriptPlayerURLString = [@"https:" stringByAppendingString:assets];
					
					javaScriptPlayerURL = [NSURL URLWithString:javaScriptPlayerURLString];
					*stop = YES;
				}
			}
		}
	}];
	
	if (javaScriptPlayerURL)
		[self startRequestWithURL:javaScriptPlayerURL];
	else
		[self startNextVideoInfoRequest];
}

- (void) handleJavaScriptPlayerResponse
{
	NSString *script = [[[NSString alloc] initWithData:self.connectionData encoding:NSISOLatin1StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	static NSString *jsPrologue = @"(function()";
	static NSString *jsEpilogue = @")();";
	if ([script hasPrefix:jsPrologue] && [script hasSuffix:jsEpilogue])
		script = [script substringWithRange:NSMakeRange(jsPrologue.length, script.length - (jsPrologue.length + jsEpilogue.length))];
	
	JSContext *context = [NSClassFromString(@"JSContext") new];
	[context evaluateScript:script];
	__block NSString *signatureFunctionName = nil;
	NSRegularExpression *signatureRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"signature\\s*=\\s*([a-zA-Z]+)" options:NSRegularExpressionCaseInsensitive error:NULL];
	[signatureRegularExpression enumerateMatchesInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		signatureFunctionName = [script substringWithRange:[result rangeAtIndex:1]];
		*stop = YES;
	}];
	JSValue *signatureFunction = signatureFunctionName ? context[signatureFunctionName] : nil;
	
	if (signatureFunction)
		[self handleVideoInfoResponseWithInfo:self.info signatureFunction:signatureFunction];
	else
		[self startNextVideoInfoRequest];
}

- (void) finishWithVideo:(XCDYouTubeVideo *)video
{
	self.video = video;
	[self finish];
}

- (void) finishWithError:(NSError *)error
{
	self.error = error;
	[self finish];
}

#pragma mark - NSOperation

+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key
{
	SEL selector = NSSelectorFromString(key);
	return selector == @selector(isExecuting) || selector == @selector(isFinished) || [super automaticallyNotifiesObserversForKey:key];
}

- (BOOL) isConcurrent
{
	return YES;
}

- (void) start
{
	if ([self isCancelled])
	{
		self.isFinished = YES;
		return;
	}
	
	self.isExecuting = YES;
	
	self.eventLabels = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage", @"vevo", @"" ]];
	[self startNextVideoInfoRequest];
}

- (void) cancel
{
	[super cancel];
	
	[self.connection cancel];
	
	[self finish];
}

- (void) finish
{
	self.isExecuting = NO;
	self.isFinished = YES;
}

#pragma mark - NSURLConnectionDataDelegate / NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSUInteger capacity = response.expectedContentLength == NSURLResponseUnknownLength ? 0 : (NSUInteger)response.expectedContentLength;
	self.connectionData = [[NSMutableData alloc] initWithCapacity:capacity];
	self.response = response;
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.connectionData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSURL *requestURL = connection.originalRequest.URL;
	
	if ([requestURL.path isEqualToString:@"/get_video_info"])
	{
		NSString *videoQuery = [[NSString alloc] initWithData:self.connectionData encoding:NSASCIIStringEncoding];
		NSDictionary *info = XCDDictionaryWithQueryString(videoQuery, NSUTF8StringEncoding);
		[self handleVideoInfoResponseWithInfo:info signatureFunction:nil];
	}
	else if ([requestURL.path isEqualToString:@"/watch"])
	{
		[self handleWebPageResponse];
	}
	else // JavaScript Player
	{
		[self handleJavaScriptPlayerResponse];
	}
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)connectionError
{
	NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: connectionError.localizedDescription,
	                            NSUnderlyingErrorKey: connectionError };
	self.lastError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNetwork userInfo:userInfo];
	
	[self startNextVideoInfoRequest];
}

@end

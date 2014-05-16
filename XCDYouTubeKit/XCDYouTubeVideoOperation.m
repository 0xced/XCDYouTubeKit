//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoOperation.h"

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"
#import "XCDYouTubePlayerScript.h"

@interface XCDYouTubeVideoOperation () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (atomic, copy, readonly) NSString *videoIdentifier;
@property (atomic, copy, readonly) NSString *languageIdentifier;

@property (atomic, strong) NSURLConnection *connection;
@property (atomic, strong) NSURLResponse *response;
@property (atomic, strong) NSMutableData *connectionData;
@property (atomic, strong) NSMutableArray *eventLabels;

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@property (atomic, strong) NSDictionary *info;
@property (atomic, strong) XCDYouTubeVideo *noStreamVideo;
@property (atomic, strong) NSError *lastError;
@property (atomic, strong) NSError *youTubeError; // Error actually coming from the YouTube API, i.e. explicit and localized error

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
		
		NSDictionary *query = @{ @"video_id": self.videoIdentifier, @"hl": self.languageIdentifier, @"el": eventLabel, @"ps": @"default" };
		NSString *queryString = XCDQueryStringWithDictionary(query, NSUTF8StringEncoding);
		NSURL *videoInfoURL = [NSURL URLWithString:[@"https://www.youtube.com/get_video_info?" stringByAppendingString:queryString]];
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

- (void) handleVideoInfoResponseWithInfo:(NSDictionary *)info playerScript:(XCDYouTubePlayerScript *)playerScript
{
	NSError *error = nil;
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:self.videoIdentifier info:info playerScript:playerScript response:self.response error:&error];
	if (video)
	{
		[video mergeVideo:self.noStreamVideo];
		[self finishWithVideo:video];
	}
	else
	{
		if ([error.domain isEqual:XCDYouTubeVideoErrorDomain] && error.code == XCDYouTubeErrorUseCipherSignature)
		{
			self.noStreamVideo = error.userInfo[XCDYouTubeNoStreamVideoUserInfoKey];
			
			NSDictionary *query = @{ @"v": self.videoIdentifier, @"hl": self.languageIdentifier, @"has_verified": @YES };
			NSString *queryString = XCDQueryStringWithDictionary(query, NSUTF8StringEncoding);
			NSURL *webpageURL = [NSURL URLWithString:[@"https://www.youtube.com/watch?" stringByAppendingString:queryString]];
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
	[playerConfigRegularExpression enumerateMatchesInString:html options:(NSMatchingOptions)0 range:NSMakeRange(0, html.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *regexpStop) {
		NSString *configString = [html substringWithRange:[result rangeAtIndex:1]];
		NSDictionary *playerConfiguration = [NSJSONSerialization JSONObjectWithData:[configString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingOptions)0 error:NULL];
		if ([playerConfiguration isKindOfClass:[NSDictionary class]])
		{
			NSDictionary *args = playerConfiguration[@"args"];
			if ([args isKindOfClass:[NSDictionary class]])
			{
				NSMutableDictionary *info = [NSMutableDictionary new];
				[args enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *argsStop) {
					if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
						info[key] = [value description];
				}];
				self.info = [info copy];
				NSString *jsAssets = [playerConfiguration valueForKeyPath:@"assets.js"];
				if ([jsAssets isKindOfClass:[NSString class]])
				{
					NSString *javaScriptPlayerURLString = jsAssets;
					if ([jsAssets hasPrefix:@"//"])
						javaScriptPlayerURLString = [@"https:" stringByAppendingString:jsAssets];
					
					javaScriptPlayerURL = [NSURL URLWithString:javaScriptPlayerURLString];
					*regexpStop = YES;
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
	XCDYouTubePlayerScript *playerScript = [[XCDYouTubePlayerScript alloc] initWithString:script];
	
	if (playerScript)
		[self handleVideoInfoResponseWithInfo:self.info playerScript:playerScript];
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
	
	self.eventLabels = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage", @"vevo" ]];
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
		[self handleVideoInfoResponseWithInfo:info playerScript:nil];
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

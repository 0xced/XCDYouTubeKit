//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoOperation.h"

#import <objc/runtime.h>

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"
#import "XCDYouTubeVideoWebpage.h"
#import "XCDYouTubeDashManifestXML.h"
#import "XCDYouTubePlayerScript.h"
#import "XCDYouTubeLogger+Private.h"
#import "XCDYouTubeClient.h"

typedef NS_ENUM(NSUInteger, XCDYouTubeRequestType) {
	XCDYouTubeRequestTypeGetVideoInfo = 1,
	XCDYouTubeRequestTypeWatchPage,
	XCDYouTubeRequestTypeEmbedPage,
	XCDYouTubeRequestTypeJavaScriptPlayer,
	XCDYouTubeRequestTypeDashManifest,
	
};

@interface XCDYouTubeVideoOperation ()
@property (atomic, copy, readonly) NSString *videoIdentifier;
@property (atomic, copy, readonly) NSString *languageIdentifier;
@property (atomic, strong, readonly) NSArray <NSHTTPCookie *> *cookies;
@property (atomic, strong, readonly) NSArray <NSString *> *customPatterns;
@property (atomic, assign) BOOL ranLastEmbedPage;
@property (atomic, assign) NSInteger requestCount;
@property (atomic, assign) XCDYouTubeRequestType requestType;
@property (atomic, strong) NSMutableArray *eventLabels;
@property (atomic, strong) XCDYouTubeVideo *lastSuccessfulVideo;
@property (atomic, readonly) NSURLSession *session;
@property (atomic, strong) NSURLSessionDataTask *dataTask;

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;
@property (atomic, readonly) dispatch_semaphore_t operationStartSemaphore;

@property (atomic, strong) XCDYouTubeVideoWebpage *webpage;
@property (atomic, strong) XCDYouTubeVideoWebpage *embedWebpage;
@property (atomic, strong) XCDYouTubePlayerScript *playerScript;
@property (atomic, strong) XCDYouTubeVideo *noStreamVideo;
@property (atomic, strong) NSError *lastError;
@property (atomic, strong) NSError *youTubeError; // Error actually coming from the YouTube API, i.e. explicit and localized error

@property (atomic, strong, readwrite) NSError *error;
@property (atomic, strong, readwrite) XCDYouTubeVideo *video;
@end

@implementation XCDYouTubeVideoOperation

static NSError *YouTubeError(NSError *error, NSSet *regionsAllowed, NSString *languageIdentifier)
{
	if (error.code == XCDYouTubeErrorNoStreamAvailable && regionsAllowed.count > 0)
	{
		NSLocale *locale = [NSLocale localeWithLocaleIdentifier:languageIdentifier];
		NSMutableSet *allowedCountries = [NSMutableSet new];
		for (NSString *countryCode in regionsAllowed)
		{
			NSString *country = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
			[allowedCountries addObject:country ?: countryCode];
		}
		NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
		userInfo[XCDYouTubeAllowedCountriesUserInfoKey] = [allowedCountries copy];
		return [NSError errorWithDomain:error.domain code:error.code userInfo:[userInfo copy]];
	}
	else
	{
		return error;
	}
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype) init
{
	@throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithVideoIdentifier:cookies:languageIdentifier:` method instead." userInfo:nil];
} // LCOV_EXCL_LINE
#pragma clang diagnostic pop

- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier cookies:(NSArray<NSHTTPCookie *> *)cookies customPatterns:(NSArray<NSString *> *)customPatterns
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	_videoIdentifier = videoIdentifier ?: @"";
	_languageIdentifier = languageIdentifier ?: @"en";
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
	_cookies = [cookies copy];
	_customPatterns = [customPatterns copy];
	
	for (NSHTTPCookie *cookie in _cookies) {
		[configuration.HTTPCookieStorage setCookie:cookie];
	}
	
	NSString *cookieValue = [NSString stringWithFormat:@"f1=50000000&f6=8&hl=%@", _languageIdentifier];
	
	NSHTTPCookie *additionalCookie = [NSHTTPCookie cookieWithProperties:@{
																		NSHTTPCookiePath: @"/",
																		NSHTTPCookieName: @"PREF",
																		NSHTTPCookieValue: cookieValue,
																		NSHTTPCookieDomain:@".youtube.com",
																		NSHTTPCookieSecure:@"TRUE"
	}];

	[configuration.HTTPCookieStorage setCookie:additionalCookie];
	configuration.HTTPAdditionalHeaders = @{@"User-Agent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15"};
	_session = [NSURLSession sessionWithConfiguration:configuration];
	_operationStartSemaphore = dispatch_semaphore_create(0);
	
	return self;
}

- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier
{
	return [self initWithVideoIdentifier:videoIdentifier languageIdentifier:languageIdentifier cookies:nil customPatterns:nil];
}

- (instancetype) initWithVideoIdentifier:(NSString *)videoIdentifier languageIdentifier:(NSString *)languageIdentifier cookies:(NSArray<NSHTTPCookie *> *)cookies
{
	return [self initWithVideoIdentifier:videoIdentifier languageIdentifier:languageIdentifier cookies:cookies customPatterns:nil];
}

#pragma mark - Requests

- (void) startNextRequest
{
	if (self.eventLabels.count == 0)
	{
		if (self.requestType == XCDYouTubeRequestTypeWatchPage || self.webpage)
		{
			if (self.ranLastEmbedPage == NO) {
				[self startLastEmbedPageRequest];
				return;
			}
			[self finishWithError];
		}
		else
		{
			[self startWatchPageRequest];
		}
	}
	else
	{
		[self.eventLabels removeObjectAtIndex:0];
		
		NSString *urlString = [NSString stringWithFormat:@"https://youtubei.googleapis.com/youtubei/v1/player?key=%@", XCDYouTubeClient.innertubeApiKey];
		NSURL *url = [NSURL URLWithString:urlString];
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
		
		[request setHTTPMethod:@"POST"];
		
		NSString *string = [NSString stringWithFormat:@"{'context': {'client': {'hl': 'en','clientName': 'WEB','clientVersion': '2.20210721.00.00','mainAppWebInfo': {'graftUrl': '/watch?v=%@'}}},'videoId': '%@'}", self.videoIdentifier, self.videoIdentifier];
		
		NSData *postData = [string dataUsingEncoding:NSASCIIStringEncoding];
		
		[request setHTTPBody:postData];
		
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		
		[self startRequestWith:request type:XCDYouTubeRequestTypeGetVideoInfo];
	}
}

- (void) startWatchPageRequest
{
	NSDictionary *query = @{ @"v": self.videoIdentifier, @"hl": self.languageIdentifier, @"has_verified": @YES, @"bpctr": @9999999999 };
	NSString *queryString = XCDQueryStringWithDictionary(query);
	NSURL *webpageURL = [NSURL URLWithString:[@"https://www.youtube.com/watch?" stringByAppendingString:queryString]];
	[self startRequestWithURL:webpageURL type:XCDYouTubeRequestTypeWatchPage];
}

// Last resort request, sometimes the `javaScriptPlayerURL` will randomly not appear on `webpage` but will appear on the `embedWebpage` regardless of age restrictions. This appears to be how youtube-dl handles it, see https://github.com/l1ving/youtube-dl/blob/4fcd20a46cbf35ebbeaf06dde3999ad4309d7a8e/youtube_dl/extractor/youtube.py#L1963
- (void) startLastEmbedPageRequest
{
	self.ranLastEmbedPage = YES;
	NSString *embedURLString = [NSString stringWithFormat:@"https://www.youtube.com/embed/%@", self.videoIdentifier];
	[self startRequestWithURL:[NSURL URLWithString:embedURLString] type:XCDYouTubeRequestTypeEmbedPage];
}

- (void) startRequestWithURL:(NSURL *)url type:(XCDYouTubeRequestType)requestType
{
	if (self.isCancelled)
		return;
	
	// Max (age-restricted VEVO) = 2×GetVideoInfo + 1×WatchPage + 2×EmbedPage + 1×JavaScriptPlayer + 1×GetVideoInfo + 1xDashManifest
	if (++self.requestCount > 8)
	{
		// This condition should never happen but the request flow is quite complex so better abort here than go into an infinite loop of requests
		[self finishWithError];
		return;
	}
	
	XCDYouTubeLogDebug(@"Starting request: %@", url);
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:self.languageIdentifier forHTTPHeaderField:@"Accept-Language"];
	[request setValue:[NSString stringWithFormat:@"https://youtube.com/watch?v=%@", self.videoIdentifier] forHTTPHeaderField:@"Referer"];
	
	self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
	{
		if (self.isCancelled)
			return;
		
		if (error)
			[self handleConnectionError:error requestType:requestType];
		else
			[self handleConnectionSuccessWithData:data response:response requestType:requestType];
	}];
	[self.dataTask resume];
	
	self.requestType = requestType;
}

- (void) startRequestWith:(NSMutableURLRequest *)request type:(XCDYouTubeRequestType)requestType
{
	if (self.isCancelled)
		return;
	
	// Max (age-restricted VEVO) = 2×GetVideoInfo + 1×WatchPage + 2×EmbedPage + 1×JavaScriptPlayer + 1×GetVideoInfo + 1xDashManifest
	if (++self.requestCount > 8)
	{
		// This condition should never happen but the request flow is quite complex so better abort here than go into an infinite loop of requests
		[self finishWithError];
		return;
	}
	
	XCDYouTubeLogDebug(@"Starting request: %@", [request URL]);
	
	[request setValue:self.languageIdentifier forHTTPHeaderField:@"Accept-Language"];
	[request setValue:[NSString stringWithFormat:@"https://youtube.com/watch?v=%@", self.videoIdentifier] forHTTPHeaderField:@"Referer"];
	
	self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
	{
		if (self.isCancelled)
			return;
		
		if (error)
			[self handleConnectionError:error requestType:requestType];
		else
			[self handleConnectionSuccessWithData:data response:response requestType:requestType];
	}];
	[self.dataTask resume];
	
	self.requestType = requestType;
}

#pragma mark - Response Dispatch

- (void) handleConnectionSuccessWithData:(NSData *)data response:(NSURLResponse *)response requestType:(XCDYouTubeRequestType)requestType
{
	CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)response.textEncodingName ?: CFSTR(""));
	// Use kCFStringEncodingMacRoman as fallback because it defines characters for every byte value and is ASCII compatible. See https://mikeash.com/pyblog/friday-qa-2010-02-19-character-encodings.html
	NSString *responseString = CFBridgingRelease(CFStringCreateWithBytes(kCFAllocatorDefault, data.bytes, (CFIndex)data.length, encoding != kCFStringEncodingInvalidId ? encoding : kCFStringEncodingMacRoman, false)) ?: @"";
	
	XCDYouTubeLogVerbose(@"Response: %@\n%@", response, responseString);
	if ([(NSHTTPURLResponse *)response statusCode] == 429)
	{
		//See 429 indicates too many requests https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429
		// This can happen when YouTube blocks the clients because of too many requests
		[self handleConnectionError:[NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorTooManyRequests userInfo:@{NSLocalizedDescriptionKey : @"The operation couldn’t be completed because too many requests were sent."}] requestType:requestType];
		return;
	}
	if (responseString.length == 0)
	{
		//Previously we would throw an assertion here, however, this has been changed to an error
		//See more here https://github.com/0xced/XCDYouTubeKit/issues/479
		self.lastError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorEmptyResponse userInfo:nil];
		XCDYouTubeLogError(@"Failed to decode response from %@ (response.textEncodingName = %@, data.length = %@)", response.URL, response.textEncodingName, @(data.length));
		[self finishWithError];
		return;
	}
	
	switch (requestType)
	{
		case XCDYouTubeRequestTypeGetVideoInfo:
			[self handleVideoInfoResponseWithInfo:XCDDictionaryWithQueryString(responseString) response:response];
			break;
		case XCDYouTubeRequestTypeWatchPage:
			[self handleWebPageWithHTMLString:responseString];
			break;
		case XCDYouTubeRequestTypeEmbedPage:
			[self handleEmbedWebPageWithHTMLString:responseString];
			break;
		case XCDYouTubeRequestTypeJavaScriptPlayer:
			[self handleJavaScriptPlayerWithScript:responseString];
			break;
		case XCDYouTubeRequestTypeDashManifest:
			[self handleDashManifestWithXMLString:responseString response:response];
			break;
	}
}

- (void) handleConnectionError:(NSError *)connectionError requestType:(XCDYouTubeRequestType)requestType
{
	//Shoud not return a connection error if was as a result of requesting the Dash Manifiest (we have a sucessfully created `XCDYouTubeVideo` and should just finish the operation as if were a 'sucessful' one
	if (requestType == XCDYouTubeRequestTypeDashManifest)
	{
		[self finishWithVideo:self.lastSuccessfulVideo];
		return;
	}
	
	NSDictionary *userInfo = @{	NSLocalizedDescriptionKey: connectionError.localizedDescription,
								NSUnderlyingErrorKey: connectionError };
	self.lastError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNetwork userInfo:userInfo];
	
	[self startNextRequest];
}

#pragma mark - Response Parsing

- (void) handleVideoInfoResponseWithInfo:(NSDictionary *)info response:(NSURLResponse *)response
{
	XCDYouTubeLogDebug(@"Handling video info response");
	
	NSError *error = nil;
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:self.videoIdentifier info:info playerScript:self.playerScript response:response error:&error];
	if (video)
	{
		self.lastSuccessfulVideo = video;
		
		if (info[@"dashmpd"])
		{
			NSURL *dashmpdURL = [NSURL URLWithString:(NSString *_Nonnull)info[@"dashmpd"]];
			[self startRequestWithURL:dashmpdURL type:XCDYouTubeRequestTypeDashManifest];
			return;
		}
		[video mergeVideo:self.noStreamVideo];
		[self finishWithVideo:video];
	}
	else
	{
		if ([error.domain isEqual:XCDYouTubeVideoErrorDomain] && error.code == XCDYouTubeErrorUseCipherSignature)
		{
			self.noStreamVideo = error.userInfo[XCDYouTubeNoStreamVideoUserInfoKey];
			
			[self startWatchPageRequest];
		}
		else
		{
			self.lastError = error;
			if (error.userInfo[NSLocalizedDescriptionKey])
				self.youTubeError = error;
			
			[self startNextRequest];
		}
	}
}

- (void) handleWebPageWithHTMLString:(NSString *)html
{
	XCDYouTubeLogDebug(@"Handling web page response");
	
	self.webpage = [[XCDYouTubeVideoWebpage alloc] initWithHTMLString:html];
	
	if (self.webpage.javaScriptPlayerURL)
	{
		[self startRequestWithURL:self.webpage.javaScriptPlayerURL type:XCDYouTubeRequestTypeJavaScriptPlayer];
	}
	else
	{
		if (self.webpage.isAgeRestricted)
		{
			NSString *embedURLString = [NSString stringWithFormat:@"https://www.youtube.com/embed/%@", self.videoIdentifier];
			[self startRequestWithURL:[NSURL URLWithString:embedURLString] type:XCDYouTubeRequestTypeEmbedPage];
		}
		else
		{
			[self startNextRequest];
		}
	}
}

- (void) handleEmbedWebPageWithHTMLString:(NSString *)html
{
	XCDYouTubeLogDebug(@"Handling embed web page response");
	
	self.embedWebpage = [[XCDYouTubeVideoWebpage alloc] initWithHTMLString:html];
	
	if (self.embedWebpage.javaScriptPlayerURL)
	{
		[self startRequestWithURL:self.embedWebpage.javaScriptPlayerURL type:XCDYouTubeRequestTypeJavaScriptPlayer];
	}
	else
	{
		[self startNextRequest];
	}
}

- (void) handleJavaScriptPlayerWithScript:(NSString *)script
{
	XCDYouTubeLogDebug(@"Handling JavaScript player response");
	
	self.playerScript = [[XCDYouTubePlayerScript alloc] initWithString:script customPatterns:self.customPatterns];
	
	if (self.webpage.isAgeRestricted && self.cookies.count == 0)
	{
		NSString *eurl = [@"https://youtube.googleapis.com/v/" stringByAppendingString:self.videoIdentifier];
		NSString *sts = self.embedWebpage.sts ?: self.webpage.sts ?: @"";
		NSDictionary *query = @{ @"video_id": self.videoIdentifier, @"hl": self.languageIdentifier, @"eurl": eurl, @"sts": sts};
		NSString *queryString = XCDQueryStringWithDictionary(query);
		NSURL *videoInfoURL = [NSURL URLWithString:[@"https://www.youtube.com/get_video_info?" stringByAppendingString:queryString]];
		[self startRequestWithURL:videoInfoURL type:XCDYouTubeRequestTypeGetVideoInfo];
	}
	else
	{
		[self handleVideoInfoResponseWithInfo:self.webpage.videoInfo response:nil];
	}
}

- (void) handleDashManifestWithXMLString:(NSString *)XMLString response:(NSURLResponse *)response
{
	XCDYouTubeLogDebug(@"Handling Dash Manifest response");
	
	XCDYouTubeDashManifestXML *dashManifestXML = [[XCDYouTubeDashManifestXML alloc]initWithXMLString:XMLString];
	NSDictionary *dashhManifestStreamURLs = dashManifestXML.streamURLs;
	if (dashhManifestStreamURLs)
		[self.lastSuccessfulVideo mergeDashManifestStreamURLs:dashhManifestStreamURLs];
	
	[self finishWithVideo:self.lastSuccessfulVideo];
}

#pragma mark - Finish Operation

- (void) finishWithVideo:(XCDYouTubeVideo *)video
{
	self.video = video;
	XCDYouTubeLogInfo(@"Video operation finished with success: %@", video);
	XCDYouTubeLogDebug(@"%@", ^{ return video.debugDescription; }());
	[self finish];
}

- (void) finishWithError
{
	self.error = self.youTubeError ? YouTubeError(self.youTubeError, self.webpage.regionsAllowed, self.languageIdentifier) : self.lastError;
	if (self.error == nil)
	{
		//This condition should never happen but as a last resort.
		//See https://github.com/0xced/XCDYouTubeKit/issues/484
		self.error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorUnknown userInfo:@{NSLocalizedDescriptionKey : @"The operation couldn’t be completed because of an unknown error."}];
	}
	XCDYouTubeLogError(@"Video operation finished with error: %@\nDomain: %@\nCode:   %@\nUser Info: %@", self.error.localizedDescription, self.error.domain, @(self.error.code), self.error.userInfo);
	[self finish];
}

- (void) finish
{
	self.isExecuting = NO;
	self.isFinished = YES;
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
	dispatch_semaphore_signal(self.operationStartSemaphore);
	
	if (self.isCancelled)
		return;
	
	if (self.videoIdentifier.length != 11)
	{
		XCDYouTubeLogWarning(@"Video identifier length should be 11. [%@]", self.videoIdentifier);
	}
	
	XCDYouTubeLogInfo(@"Starting video operation: %@", self);
	
	self.isExecuting = YES;
	
	self.eventLabels = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage" ]];
	[self startNextRequest];
}

- (void) cancel
{
	if (self.isCancelled || self.isFinished)
		return;
	
	XCDYouTubeLogInfo(@"Canceling video operation: %@", self);
	
	[super cancel];
	
	[self.dataTask cancel];
	
	// Wait for `start` to be called in order to avoid this warning: *** XCDYouTubeVideoOperation 0x7f8b18c84880 went isFinished=YES without being started by the queue it is in
	dispatch_semaphore_wait(self.operationStartSemaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)));
	[self finish];
}

#pragma mark - NSObject

- (NSString *) description
{
	return [NSString stringWithFormat:@"<%@: %p> %@ (%@)", self.class, self, self.videoIdentifier, self.languageIdentifier];
}

@end

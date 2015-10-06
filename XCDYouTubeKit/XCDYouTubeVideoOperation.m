//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoOperation.h"

#import <objc/runtime.h>

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"
#import "XCDYouTubeVideoWebpage.h"
#import "XCDYouTubePlayerScript.h"
#import "XCDYouTubeLogger.h"

static const void * const XCDYouTubeRequestTypeKey = &XCDYouTubeRequestTypeKey;

typedef NS_ENUM(NSUInteger, XCDYouTubeRequestType) {
	XCDYouTubeRequestTypeGetVideoInfo = 1,
	XCDYouTubeRequestTypeWatchPage,
	XCDYouTubeRequestTypeEmbedPage,
	XCDYouTubeRequestTypeJavaScriptPlayer,
};

@interface XCDYouTubeVideoOperation () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (atomic, copy, readonly) NSString *videoIdentifier;
@property (atomic, copy, readonly) NSString *languageIdentifier;

@property (nonatomic) XCDYouTubeRequestType requestType;
@property (atomic, assign) NSInteger requestCount;
@property (atomic, strong) NSURLSessionDataTask *task;
@property (atomic, strong) NSURLResponse *response;
@property (atomic, strong) NSData *responseData;
@property (atomic, strong) NSMutableArray *eventLabels;

@property (atomic, assign) BOOL keepRunning;

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
	
	_keepRunning = YES;
	
	return self;
}

- (void) startNextRequest
{
	if (self.eventLabels.count == 0)
	{
		if (self.requestType == XCDYouTubeRequestTypeWatchPage || self.webpage)
			[self finishWithError];
		else
			[self startWatchPageRequest];
	}
	else
	{
		NSString *eventLabel = [self.eventLabels objectAtIndex:0];
		[self.eventLabels removeObjectAtIndex:0];
		
		NSDictionary *query = @{ @"video_id": self.videoIdentifier, @"hl": self.languageIdentifier, @"el": eventLabel, @"ps": @"default" };
		NSString *queryString = XCDQueryStringWithDictionary(query, NSUTF8StringEncoding);
		NSURL *videoInfoURL = [NSURL URLWithString:[@"https://www.youtube.com/get_video_info?" stringByAppendingString:queryString]];
		[self startRequestWithURL:videoInfoURL type:XCDYouTubeRequestTypeGetVideoInfo];
	}
}

- (void) startWatchPageRequest
{
	NSDictionary *query = @{ @"v": self.videoIdentifier, @"hl": self.languageIdentifier, @"has_verified": @YES };
	NSString *queryString = XCDQueryStringWithDictionary(query, NSUTF8StringEncoding);
	NSURL *webpageURL = [NSURL URLWithString:[@"https://www.youtube.com/watch?" stringByAppendingString:queryString]];
	[self startRequestWithURL:webpageURL type:XCDYouTubeRequestTypeWatchPage];
}

- (void) startRequestWithURL:(NSURL *)url type:(XCDYouTubeRequestType)requestType
{
	// Max (age-restricted VEVO) = 2×GetVideoInfo + 1×WatchPage + 1×EmbedPage + 1×JavaScriptPlayer + 1×GetVideoInfo
	if (++self.requestCount > 6)
	{
		// This condition should never happen but the request flow is quite complex so better abort here than go into an infinite loop of requests
		[self finishWithError];
		return;
	}
	
	XCDYouTubeLogDebug(@"Starting request: %@", url);
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:self.languageIdentifier forHTTPHeaderField:@"Accept-Language"];

	NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	self.task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

		if (error) {
			NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: error.localizedDescription,
										NSUnderlyingErrorKey: error };
			self.lastError = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNetwork userInfo:userInfo];

			[self startNextRequest];
		} else {
		self.responseData = data;
		self.response = response;

		switch (requestType)
		{
			case XCDYouTubeRequestTypeGetVideoInfo:
			{
				NSString *videoQuery = [[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding];
				NSDictionary *info = XCDDictionaryWithQueryString(videoQuery, NSUTF8StringEncoding);
				[self handleVideoInfoResponseWithInfo:info];
			}
				break;
			case XCDYouTubeRequestTypeWatchPage:
				[self handleWebPageResponse];
				break;
			case XCDYouTubeRequestTypeEmbedPage:
				[self handleEmbedWebPageResponse];
				break;
			case XCDYouTubeRequestTypeJavaScriptPlayer:
				[self handleJavaScriptPlayerResponse];
				break;
		}
		}
	}];
	self.requestType = requestType;
	[self.task resume];
}

- (void) handleVideoInfoResponseWithInfo:(NSDictionary *)info
{
	XCDYouTubeLogDebug(@"Handling video info response");
	XCDYouTubeLogVerbose(@"Video info: %@", info);
	
	NSError *error = nil;
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:self.videoIdentifier info:info playerScript:self.playerScript response:self.response error:&error];
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
			
			[self startWatchPageRequest];
		}
		else
		{
			self.lastError = error;
			if (error.code > 0)
				self.youTubeError = error;
			
			[self startNextRequest];
		}
	}
}

- (void) handleWebPageResponse
{
	XCDYouTubeLogDebug(@"Handling web page response");
	
	self.webpage = [[XCDYouTubeVideoWebpage alloc] initWithData:self.responseData response:self.response];
	
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

- (void) handleEmbedWebPageResponse
{
	XCDYouTubeLogDebug(@"Handling embed web page response");
	
	self.embedWebpage = [[XCDYouTubeVideoWebpage alloc] initWithData:self.responseData response:self.response];
	
	if (self.embedWebpage.javaScriptPlayerURL)
	{
		[self startRequestWithURL:self.embedWebpage.javaScriptPlayerURL type:XCDYouTubeRequestTypeJavaScriptPlayer];
	}
	else
	{
		[self startNextRequest];
	}
}

- (void) handleJavaScriptPlayerResponse
{
	XCDYouTubeLogDebug(@"Handling JavaScript player response");
	
	NSString *script = [[NSString alloc] initWithData:self.responseData encoding:NSISOLatin1StringEncoding];
	self.playerScript = [[XCDYouTubePlayerScript alloc] initWithString:script];
	
	if (self.webpage.isAgeRestricted)
	{
		NSString *eurl = [@"https://youtube.googleapis.com/v/" stringByAppendingString:self.videoIdentifier];
		NSString *sts = [self.embedWebpage.playerConfiguration[@"sts"] description] ?: [self.webpage.playerConfiguration[@"sts"] description] ?: @"";
		NSDictionary *query = @{ @"video_id": self.videoIdentifier, @"hl": self.languageIdentifier, @"eurl": eurl, @"sts": sts};
		NSString *queryString = XCDQueryStringWithDictionary(query, NSUTF8StringEncoding);
		NSURL *videoInfoURL = [NSURL URLWithString:[@"https://www.youtube.com/get_video_info?" stringByAppendingString:queryString]];
		[self startRequestWithURL:videoInfoURL type:XCDYouTubeRequestTypeGetVideoInfo];
	}
	else
	{
		[self handleVideoInfoResponseWithInfo:self.webpage.videoInfo];
	}
}

- (void) finishWithVideo:(XCDYouTubeVideo *)video
{
	self.video = video;
	XCDYouTubeLogInfo(@"Video operation finished with success: %@", video);
	XCDYouTubeLogDebug(@"%@", video.debugDescription);
	[self finish];
}

- (void) finishWithError
{
	self.error = self.youTubeError ?: self.lastError;
	XCDYouTubeLogError(@"Video operation finished with error: %@\nDomain: %@\nCode:   %@\nUser Info: %@", self.error.localizedDescription, self.error.domain, @(self.error.code), self.error.userInfo);
	[self finish];
}

#pragma mark - NSOperation

- (void) main
{
	if ([NSThread isMainThread])
		@throw [NSException exceptionWithName:NSGenericException reason:@"XCDYouTubeVideoOperation must not be executed on the main thread." userInfo:nil];
	
	XCDYouTubeLogInfo(@"Starting video operation: %@", self);
	
	self.eventLabels = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage" ]];
	[self startNextRequest];
	
	while (self.keepRunning)
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
}

- (void) cancel
{
	if (self.isCancelled || self.isFinished)
		return;
	
	XCDYouTubeLogInfo(@"Canceling video operation: %@", self);
	
	[super cancel];
	
	[self.task cancel];
	
	[self finish];
}

- (void) finish
{
	self.keepRunning = NO;
}


#pragma mark - NSObject

- (NSString *) description
{
	return [NSString stringWithFormat:@"<%@: %p> %@ (%@)", self.class, self, self.videoIdentifier, self.languageIdentifier];
}

@end

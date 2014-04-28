//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoOperation.h"

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"

@interface XCDYouTubeVideoOperation () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (atomic, copy, readonly) NSString *videoIdentifier;
@property (atomic, copy, readonly) NSString *languageIdentifier;

@property (atomic, strong) NSURLConnection *connection;
@property (atomic, strong) NSURLResponse *response;
@property (atomic, strong) NSMutableData *connectionData;
@property (atomic, strong) NSMutableArray *eventLabels;

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

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

- (void) startVideoInfoRequest
{
	NSString *eventLabel = [self.eventLabels objectAtIndex:0];
	[self.eventLabels removeObjectAtIndex:0];
	if (eventLabel.length > 0)
		eventLabel = [@"&el=" stringByAppendingString:eventLabel];
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=%@", self.videoIdentifier, eventLabel, self.languageIdentifier]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:self.languageIdentifier forHTTPHeaderField:@"Accept-Language"];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
	[connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
	[connection start];
	self.connection = connection;
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
	return selector == @selector(isExecuting) || selector == @selector(isFinished) ? YES : [super automaticallyNotifiesObserversForKey:key];
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
	[self startVideoInfoRequest];
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
	NSError *error = nil;
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:self.videoIdentifier response:self.response data:self.connectionData error:&error];
	if (video)
		[self finishWithVideo:video];
	else if (self.eventLabels.count > 0)
		[self startVideoInfoRequest];
	else
		[self finishWithError:error];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)connectionError
{
	NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: connectionError.localizedDescription,
	                            NSUnderlyingErrorKey: connectionError };
	NSError *error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNetwork userInfo:userInfo];
	[self finishWithError:error];
}

@end

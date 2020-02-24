//
//  XCDYouTubeVideoQueryOperation.m
//  XCDYouTubeKit Static Library
//
//  Created by Soneé John on 2/12/20.
//  Copyright © 2020 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoQueryOperation.h"
#import "XCDURLHEADOperation.h"
#import "XCDYouTubeError.h"
#import "XCDURLGETOperation.h"
#import "XCDYouTubeLogger+Private.h"

@interface XCDYouTubeVideoQueryOperation ()

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@property (atomic, readwrite) NSDictionary<id, NSURL *> *streamURLs;
@property (atomic, readwrite, nullable) NSError *error;
@property (atomic, readwrite, nullable) NSDictionary<id, NSError *> *streamErrors;

@property (atomic, strong, readwrite, nullable) NSDictionary<id, NSURL *> *streamURLsToQuery;
@property (atomic, strong) NSOperationQueue *queryQueue;
@property (atomic, readonly) dispatch_semaphore_t operationStartSemaphore;
@end

@implementation XCDYouTubeVideoQueryOperation

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
	@throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithVideo:streamURLsToQuery:options:cookies:` method instead." userInfo:nil];
}
#pragma clang diagnostic pop

- (instancetype)initWithVideo:(XCDYouTubeVideo *)video streamURLsToQuery:(NSDictionary<id,NSURL *> *)streamURLsToQuery options:(NSDictionary *)options cookies:(NSArray<NSHTTPCookie *> *)cookies
{
	if (video == nil)
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`video` must not be nil" userInfo:nil];

	if (!(self = [super init]))
		return nil;

	_video = video;

	NSMutableDictionary *streamURLsToQueryMutable = [NSMutableDictionary new];

	for (id key in streamURLsToQuery)
	{
		//If the `video` object `streamURLs` does not contain this key we skip.
		//Or, if value of the key isn't in the `video` object `streamURLs` we also skip.
		if (_video.streamURLs[key] == nil || [(NSURL *)_video.streamURLs[key] isEqual:(NSURL *)streamURLsToQuery[key]] == NO)
		{
			continue;
		}
		streamURLsToQueryMutable[key] = _video.streamURLs[key];
	}

	if (streamURLsToQueryMutable.count == 0)
	{
		//No key and value matched so we disregard `streamURLs` and simply use the `streamURLs` from the `video` object
		_streamURLsToQuery = _video.streamURLs;
	}
	else
	{
		_streamURLsToQuery = streamURLsToQueryMutable.copy;
	}
	_cookies = [cookies copy];

	_queryQueue = [NSOperationQueue new];
	_queryQueue.name = [NSString stringWithFormat:@"%@ Query Queue", NSStringFromClass(self.class)];
	_queryQueue.maxConcurrentOperationCount = 6; // paul_irish: Chrome re-confirmed that the 6 connections-per-host limit is the right magic number: https://code.google.com/p/chromium/issues/detail?id=285567#c14 [https://twitter.com/paul_irish/status/422808635698212864]

	_operationStartSemaphore = dispatch_semaphore_create(0);
	return self;
}

- (instancetype) initWithVideo:(XCDYouTubeVideo *)video cookies:(nullable NSArray<NSHTTPCookie *> *)cookies
{
	return [self initWithVideo:video streamURLsToQuery:nil options:nil cookies:cookies];
}

#pragma mark - NSOperation

+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key
{
	SEL selector = NSSelectorFromString(key);
	return selector == @selector(isExecuting) || selector == @selector(isFinished) || [super automaticallyNotifiesObserversForKey:key];
}

- (BOOL) isAsynchronous
{
    return YES;
}

- (void) start
{
	dispatch_semaphore_signal(self.operationStartSemaphore);
	NSAssert(![NSThread isMainThread], @"Operation should never start from the main thread!");
	
	if (self.isCancelled)
		return;
	
	XCDYouTubeLogInfo(@"Starting query operation: %@", self);
	
	self.isExecuting = YES;
	[self startQuery];
}

- (void) cancel
{
	if (self.isCancelled || self.isFinished)
		return;
	
	XCDYouTubeLogInfo(@"Canceling query operation: %@", self);
	
	[super cancel];
	
	[self.queryQueue cancelAllOperations];
	
	// Wait for `start` to be called in order to avoid this warning: *** XCDYouTubeVideoOperation 0x7f8b18c84880 went isFinished=YES without being started by the queue it is in
	dispatch_semaphore_wait(self.operationStartSemaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)));
	[self finish];
}

#pragma mark -

- (void) startQuery
{
	XCDYouTubeLogDebug(@"Starting query request for video: %@", self.video);
	
	NSMutableArray <XCDURLHEADOperation *>*HEADOperations = [NSMutableArray new];
	//Always use the `video` to check if it's a live stream (clients might not include `XCDYouTubeVideoQualityHTTPLiveStreaming` in `streamURLsToQuery`)
	BOOL isHTTPLiveStream = self.video.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] != nil;
	
	[self.streamURLsToQuery enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSURL * _Nonnull obj, BOOL * _Nonnull stop)
	{
		
		XCDURLHEADOperation *operation = [[XCDURLHEADOperation alloc]initWithURL:obj info:@{key : obj} cookes:self.cookies];
		[HEADOperations addObject:operation];
		
	}];
	
	[self.queryQueue addOperations:HEADOperations waitUntilFinished:YES];
	
	if (self.isCancelled)
		return;
	
	NSMutableArray <XCDURLGETOperation *>*GETOperations = [NSMutableArray new];
	NSMutableDictionary<id, NSError *> *streamErrors = [NSMutableDictionary new];
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	
	for (XCDURLHEADOperation *HEADOperation in HEADOperations)
	{
		
		if (HEADOperation.error != nil)
		{
			NSNumber *itag = HEADOperation.info.allKeys[0];
			streamErrors[itag] = HEADOperation.error;
			continue;
		}
		
		if (HEADOperation.error == nil && [(NSHTTPURLResponse *)HEADOperation.response statusCode] == 200)
		{
			if (isHTTPLiveStream)
			{
				[streamURLs addEntriesFromDictionary:(NSDictionary *)HEADOperation.info];
			}
			else
			{
				[GETOperations addObject:[[XCDURLGETOperation alloc]initWithURL:HEADOperation.url info:HEADOperation.info cookes:HEADOperation.cookies]];
			}
		}
	}
	
	if (isHTTPLiveStream)
	{
		/**
		 * When it's a live stream all the other streams plus the live stream will cause the `XCDURLGetOperation` to take a extremely longtime to complete.
		 * Since it's a live stream clients would tend to be only interested in the `XCDYouTubeVideoQualityHTTPLiveStreaming` value and since we checked this already with the head operation then we consider these URLs to be reachable
		*/
		[self finishWithStreamURLs:streamURLs streamErrors:streamErrors];
		return;
	}
	
	[self startGETOperations:GETOperations streamErrors:streamErrors];
}

- (void) startGETOperations:(NSArray <XCDURLGETOperation *>*)GETOperations streamErrors:(NSMutableDictionary <id, NSError *> *)streamErrors
{
	[self.queryQueue addOperations:GETOperations waitUntilFinished:YES];
	
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	
	for (XCDURLGETOperation *GETOperation in GETOperations)
	{
		
		if (GETOperation.error != nil)
		{
			NSNumber *itag = GETOperation.info.allKeys[0];
			streamErrors[itag] = GETOperation.error;
			continue;
		}
		
		NSInteger statusCode = [(NSHTTPURLResponse *)GETOperation.response statusCode];
		if (GETOperation.error == nil  && (statusCode == 200 || statusCode == 206))
		{
			[streamURLs addEntriesFromDictionary:(NSDictionary *)GETOperation.info];
		}
	}
	
	[self finishWithStreamURLs:streamURLs streamErrors:streamErrors];
}

- (void) finishWithStreamURLs:(NSDictionary *)streamURLs streamErrors:(NSDictionary *)streamErrors
{
	if (streamErrors.count != 0)
		self.streamErrors = streamErrors.copy;
	
	if (streamURLs.count == 0)
	{
		NSError *error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNoStreamAvailable userInfo:@{NSLocalizedDescriptionKey : @"No stream URLs are reachable."}];
		[self finishWithError:error];
		return;
	}
	XCDYouTubeLogInfo(@"Query operation finished with success: %@", streamURLs);
	self.streamURLs = [streamURLs copy];
	[self finish];
}

- (void) finishWithError:(NSError *)error
{
	self.error = error;
	XCDYouTubeLogError(@"Query operation finished with error: %@\nDomain: %@\nCode:   %@\nUser Info: %@", self.error.localizedDescription, self.error.domain, @(self.error.code), self.error.userInfo);
	[self finish];
}

- (void) finish
{
	self.isExecuting = NO;
	self.isFinished = YES;
}

#pragma mark - NSObject

- (NSString *) description
{
	return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.video];
}

@end

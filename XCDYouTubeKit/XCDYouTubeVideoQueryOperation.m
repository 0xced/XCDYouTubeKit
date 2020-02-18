//
//  XCDYouTubeVideoQueryOperation.m
//  XCDYouTubeKit Static Library
//
//  Created by Soneé John on 2/12/20.
//  Copyright © 2020 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoQueryOperation.h"
#import "XCDURLHeadOperation.h"
#import "XCDYouTubeError.h"
#import "XCDURLGetOperation.h"

@interface XCDYouTubeVideoQueryOperation ()

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@property (atomic, readwrite) NSDictionary<id, NSURL *> *streamURLs;
@property (atomic, readwrite, nullable) NSError *error;
@property (atomic, readwrite, nullable) NSDictionary<id, NSError *> *streamErrors;

@property (atomic, strong) NSOperationQueue *queryQueue;
@property (atomic, readonly) dispatch_semaphore_t operationStartSemaphore;
@end

@implementation XCDYouTubeVideoQueryOperation

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init
{
	@throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithVideo:cookies:` method instead." userInfo:nil];
}
#pragma clang diagnostic pop

- (instancetype) initWithVideo:(XCDYouTubeVideo *)video cookies:(nullable NSArray<NSHTTPCookie *> *)cookies
{
	if (video == nil)
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"`video` must not be nil" userInfo:nil];
	
	if (!(self = [super init]))
		return nil;
	
	_video = video;
	_cookies = [cookies copy];
	
	_queryQueue = [NSOperationQueue new];
	_queryQueue.name = [NSString stringWithFormat:@"%@ Query Queue", NSStringFromClass(self.class)];
	_queryQueue.maxConcurrentOperationCount = 6; // paul_irish: Chrome re-confirmed that the 6 connections-per-host limit is the right magic number: https://code.google.com/p/chromium/issues/detail?id=285567#c14 [https://twitter.com/paul_irish/status/422808635698212864]
	
	_operationStartSemaphore = dispatch_semaphore_create(0);
	return self;
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
	
	self.isExecuting = YES;
	[self startQuery];
}

- (void) cancel
{
	if (self.isCancelled || self.isFinished)
		return;
		
	[super cancel];
	
	[self.queryQueue cancelAllOperations];
	
	// Wait for `start` to be called in order to avoid this warning: *** XCDYouTubeVideoOperation 0x7f8b18c84880 went isFinished=YES without being started by the queue it is in
	dispatch_semaphore_wait(self.operationStartSemaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)));
	[self finish];
}

#pragma mark -

- (void) startQuery
{
	NSMutableArray <XCDURLHeadOperation *>*HEADOperations = [NSMutableArray new];
	
	[self.video.streamURLs enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSURL * _Nonnull obj, BOOL * _Nonnull stop)
	{
		
		XCDURLHeadOperation *operation = [[XCDURLHeadOperation alloc]initWithURL:obj info:@{key : obj} cookes:self.cookies];
		[HEADOperations addObject:operation];
		
	}];
	
	[self.queryQueue addOperations:HEADOperations waitUntilFinished:YES];
	
	if (self.isCancelled)
		return;
	
	NSMutableArray <XCDURLGetOperation *>*GETOperations = [NSMutableArray new];
	NSMutableDictionary<id, NSError *> *streamErrors = [NSMutableDictionary new];
	
	for (XCDURLHeadOperation *HEADOperation in HEADOperations)
	{
		
		if (HEADOperation.error != nil)
		{
			NSNumber *itag = HEADOperation.info.allKeys[0];
			streamErrors[itag] = HEADOperation.error;
			continue;
		}
		
		if (HEADOperation.error == nil && [(NSHTTPURLResponse *)HEADOperation.response statusCode] == 200)
		{
			[GETOperations addObject:[[XCDURLGetOperation alloc]initWithURL:HEADOperation.url info:HEADOperation.info cookes:HEADOperation.cookies]];
		}
	}
	
	[self.queryQueue addOperations:GETOperations waitUntilFinished:YES];
	
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	
	for (XCDURLGetOperation *GETOperation in GETOperations)
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
	
	if (streamErrors.count != 0)
		self.streamErrors = streamErrors.mutableCopy;
	
	if (streamURLs.count == 0)
	{
		NSError *error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNoStreamAvailable userInfo:@{NSLocalizedDescriptionKey : @"No stream URLs are reachable!"}];
		[self finishWithError:error];
		return;
	}
	
	[self finishWithStreamURL:streamURLs];
}

- (void) finishWithStreamURL:(NSMutableDictionary *)streamURLs
{
	self.streamURLs = [streamURLs copy];
	[self finish];
}

- (void) finishWithError:(NSError *)error
{
	self.error = error;
	[self finish];
}

- (void) finish
{
	self.isExecuting = NO;
	self.isFinished = YES;
}

@end

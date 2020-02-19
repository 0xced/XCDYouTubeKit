//
//  XCDURLHeadOperation.m
//  XCDYouTubeKit
//
//  Created by Soneé John on 2/12/20.
//  Copyright © 2020 Cédric Luthi. All rights reserved.
//

#import "XCDURLHeadOperation.h"

@interface XCDURLHeadOperation ()
@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@property (atomic, strong) NSURLSessionDataTask *dataTask;
@property (atomic, strong) NSURLSession *session;
@property (atomic, readonly) dispatch_semaphore_t operationStartSemaphore;

@property (atomic, readwrite, nullable) NSData *data;
@property (atomic, readwrite, nullable) NSURLResponse *response;

@property (atomic, readwrite, nullable) NSError *error;

@end

@implementation XCDURLHeadOperation

- (instancetype) initWithURL:(NSURL *)url info:(NSDictionary *)info cookes:(NSArray<NSHTTPCookie *> *)cookies
{
	if (!(self = [super init]))
		return nil;
	
	_url = url;
	_info = [info copy];
	_cookies = [cookies copy];
	
	_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
	
	for (NSHTTPCookie *cookie in _cookies) {
		[_session.configuration.HTTPCookieStorage setCookie:cookie];
	}
	
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
	
	if (self.isCancelled)
		return;
	
	self.isExecuting = YES;
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
	request.HTTPMethod = @"HEAD";
	
	self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
	{
		if (self.isCancelled)
			return;
		
		self.data = data;
		self.response = response;
		self.error = error;
		
		self.isExecuting = NO;
		self.isFinished = YES;
		
	}];
	
	[self.dataTask resume];
}

- (void) cancel
{
	if (self.isCancelled || self.isFinished)
		return;
	
	[super cancel];
	
	[self.dataTask cancel];
	
	dispatch_semaphore_wait(self.operationStartSemaphore, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(200 * NSEC_PER_MSEC)));
	
	self.isExecuting = NO;
	self.isFinished = YES;
}

#pragma mark - NSObject

- (NSString *) description
{
	return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.url];
}

@end

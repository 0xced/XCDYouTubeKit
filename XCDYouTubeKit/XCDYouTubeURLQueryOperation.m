//
//  XCDYouTubeURLQueryOperation.m
//  XCDYouTubeKit Static Library
//
//  Created by Soneé John on 17/01/2019.
//  Copyright © 2019 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeURLQueryOperation.h"
#import "XCDYouTubeLogger+Private.h"
@interface XCDYouTubeURLQueryOperation ()
@property (atomic, strong, readonly) NSURLSession *session;
@property (atomic, strong) NSURLSessionDataTask *dataTask;

@property (atomic, assign) BOOL isExecuting;
@property (atomic, assign) BOOL isFinished;

@property (atomic, readwrite, nullable) NSData *data;
@property (atomic, readwrite, nullable) NSURLResponse *response;

@property (atomic, readwrite, nullable) NSError *error;

@end

@implementation XCDYouTubeURLQueryOperation

- (instancetype)initWithURL:(NSURL *)url info:(NSDictionary *)info cookes:(nullable NSArray<NSHTTPCookie *> *)cookies
{
	self = [super init];
	if (self)
	{
		_url = url;
		_info = info;
		_cookies = [cookies copy];
		_session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
		for (NSHTTPCookie *cookie in _cookies)
		{
			[_session.configuration.HTTPCookieStorage setCookie:cookie];
		}
	}
	
	return self;
}

#pragma mark - NSOperation

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
	SEL selector = NSSelectorFromString(key);
	return selector == @selector(isExecuting) || selector == @selector(isFinished) || [super automaticallyNotifiesObserversForKey:key];
}

- (BOOL)isAsynchronous
{
	return YES;
}

- (void)start
{
	if (self.isCancelled)
		return;
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
	request.HTTPMethod = @"HEAD";
	
	self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
	{
		if (self.isCancelled)
			return;
		
		self.data = data;
		self.response = response;
		self.error = error;
		
		XCDYouTubeLogInfo(@"URL query operation finished with status code: %ld", (long)[(NSHTTPURLResponse *)self.response statusCode]);
		XCDYouTubeLogVerbose(@"Response: %@", self.response);
		
		self.isFinished = YES;
		self.isExecuting = NO;
	}];
	
	[self.dataTask resume];
}

- (void)cancel
{
	if (self.isCancelled || self.isFinished)
		return;
	
	[super cancel];
	
	[self.dataTask cancel];
}

@end

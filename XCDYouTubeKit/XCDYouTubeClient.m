//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeClient.h"

#import "XCDYouTubeVideoOperation.h"

@interface XCDYouTubeClient ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSOperationQueue *currentQueue;

@end

@implementation XCDYouTubeClient

@synthesize languageIdentifier = _languageIdentifier;

+ (instancetype) defaultClient
{
	static XCDYouTubeClient *defaultClient;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		defaultClient = [self new];
	});
	return defaultClient;
}

- (instancetype) init
{
	return [self initWithLanguageIdentifier:nil];
}

- (instancetype) initWithLanguageIdentifier:(NSString *)languageIdentifier
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	_languageIdentifier = ^{
		return languageIdentifier ?: ^{
			NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
			NSString *preferredLocalization = preferredLocalizations.firstObject ?: @"en";
			return [NSLocale canonicalLanguageIdentifierFromString:preferredLocalization] ?: @"en";
		}();
	}();
	
	_queue = [NSOperationQueue new];
	_queue.maxConcurrentOperationCount = 6; // paul_irish: Chrome re-confirmed that the 6 connections-per-host limit is the right magic number: https://code.google.com/p/chromium/issues/detail?id=285567#c14 [https://twitter.com/paul_irish/status/422808635698212864]
	_queue.name = NSStringFromClass(self.class);
	
	return self;
}

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo * __nullable video, NSError * __nullable error))completionHandler
{
	if (!completionHandler)
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The `completionHandler` argument must not be nil." userInfo:nil];
	
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:videoIdentifier languageIdentifier:self.languageIdentifier];
	self.currentQueue = [NSOperationQueue currentQueue];
	
	operation.completionBlock = ^{
		[self.currentQueue addOperationWithBlock:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
			if (operation.video || operation.error) // If both `video` and `error` are nil, then the operation was cancelled
			{
				completionHandler(operation.video, operation.error);
			}
			else
			{
				NSError* error = operation.error ?: [NSError errorWithDomain:@"XCDYouTubeClientDomain" code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey : @"operation was cancelled or data failed to be parsed"}];
				completionHandler(nil, error);
			}
			operation.completionBlock = nil;
#pragma clang diagnostic pop
		}];
	};
	[self.queue addOperation:operation];
	return operation;
}

@end

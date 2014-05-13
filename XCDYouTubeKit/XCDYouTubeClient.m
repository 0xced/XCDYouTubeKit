//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeClient.h"

#import "XCDYouTubeVideoOperation.h"

@interface XCDYouTubeClient ()
@property (nonatomic, strong) NSOperationQueue *queue;
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
		return nil;
	
	_languageIdentifier = languageIdentifier;
	_queue = [NSOperationQueue new];
	_queue.maxConcurrentOperationCount = 6; // paul_irish: Chrome re-confirmed that the 6 connections-per-host limit is the right magic number: https://code.google.com/p/chromium/issues/detail?id=285567#c14 [https://twitter.com/paul_irish/status/422808635698212864]
	
	return self;
}

- (NSString *) languageIdentifier
{
	if (!_languageIdentifier)
	{
		_languageIdentifier = @"en";
		NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
		if (preferredLocalizations.count > 0)
			_languageIdentifier = [NSLocale canonicalLanguageIdentifierFromString:preferredLocalizations[0]];
	}
	return _languageIdentifier;
}

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler
{
	if (!completionHandler)
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"The `completionHandler` argument must not be nil." userInfo:nil];
	
	XCDYouTubeVideoOperation *operation = [[XCDYouTubeVideoOperation alloc] initWithVideoIdentifier:videoIdentifier languageIdentifier:self.languageIdentifier];
	operation.completionBlock = ^{
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
			if (operation.video || operation.error) // If both `video` and `error` are nil, then the operation was cancelled
				completionHandler(operation.video, operation.error);
			operation.completionBlock = nil;
#pragma clang diagnostic push
		}];
	};
	[self.queue addOperation:operation];
	return operation;
}

@end

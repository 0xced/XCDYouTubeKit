//
//  XCDYouTubeClient.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 17.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeClient.h"

#import "XCDYouTubeVideo+Private.h"

@interface XCDYouTubeClient () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (nonatomic, copy) NSString *videoIdentifier;
@property (nonatomic, copy) void (^completionHandler)(XCDYouTubeVideo *, NSError *);

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSMutableData *connectionData;
@property (nonatomic, strong) NSMutableArray *eventLabels;
@end

@implementation XCDYouTubeClient

@synthesize languageIdentifier = _languageIdentifier;

- (instancetype) init
{
	return [self initWithLanguageIdentifier:nil];
}

- (instancetype) initWithLanguageIdentifier:(NSString *)languageIdentifier
{
	if (!(self = [super init]))
		return nil;
	
	_languageIdentifier = languageIdentifier;
	
	return self;
}

- (NSString *) languageIdentifier
{
	if (!_languageIdentifier)
	{
		_languageIdentifier = @"en";
		NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
		if (preferredLocalizations.count > 0)
			_languageIdentifier = [NSLocale canonicalLanguageIdentifierFromString:preferredLocalizations[0]] ?: _languageIdentifier;
	}
	return _languageIdentifier;
}

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler
{
	self.videoIdentifier = videoIdentifier;
	self.completionHandler = completionHandler;
	
	self.eventLabels = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage", @"vevo", @"" ]];
	
	[self startVideoInfoRequest];

	return (id<XCDYouTubeOperation>)self.connection;
}

- (void) startVideoInfoRequest
{
	NSString *eventLabel = [self.eventLabels objectAtIndex:0];
	[self.eventLabels removeObjectAtIndex:0];
	if (eventLabel.length > 0)
		eventLabel = [@"&el=" stringByAppendingString:eventLabel];
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=%@", self.videoIdentifier ?: @"", eventLabel, self.languageIdentifier]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:self.languageIdentifier forHTTPHeaderField:@"Accept-Language"];
	[self.connection cancel];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) finishWithError:(NSError *)error
{
	self.completionHandler(nil, error);
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
		self.completionHandler(video, nil);
	else if (self.eventLabels.count > 0)
		[self startVideoInfoRequest];
	else
		[self finishWithError:error];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self finishWithError:error];
}

@end

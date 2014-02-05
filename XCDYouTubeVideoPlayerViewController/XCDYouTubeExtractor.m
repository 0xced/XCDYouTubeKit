//
//  XCDYouTubeExtractor.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Adrien Truong on 2/5/14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeExtractor.h"

#import <AVFoundation/AVFoundation.h>

static NSDictionary *DictionaryWithQueryString(NSString *string, NSStringEncoding encoding)
{
	NSMutableDictionary *dictionary = [NSMutableDictionary new];
	NSArray *fields = [string componentsSeparatedByString:@"&"];
	for (NSString *field in fields)
	{
		NSArray *pair = [field componentsSeparatedByString:@"="];
		if (pair.count == 2)
		{
			NSString *key = pair[0];
			NSString *value = [pair[1] stringByReplacingPercentEscapesUsingEncoding:encoding];
			value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
			dictionary[key] = value;
		}
	}
	return dictionary;
}

static NSString *ApplicationLanguageIdentifier(void)
{
	static NSString *applicationLanguageIdentifier;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		applicationLanguageIdentifier = @"en";
		NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
		if (preferredLocalizations.count > 0)
			applicationLanguageIdentifier = [NSLocale canonicalLanguageIdentifierFromString:preferredLocalizations[0]] ?: applicationLanguageIdentifier;
	});
	return applicationLanguageIdentifier;
}

@interface XCDYouTubeExtractor ()

@property (nonatomic, copy, readwrite) NSString *videoIdentifier;

@property (nonatomic, strong) NSMutableArray *elFields;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *connectionData;

@property (nonatomic, readwrite, getter = isExtracting) BOOL extracting;

@property (nonatomic, copy) XCDYoutubeExtractorCompletionHandler completionHandler;

@end

@implementation XCDYouTubeExtractor

#pragma mark - Convenience

+ (instancetype) extractorWithVideoIdentifier:(NSString *)videoIdentifier
{
    return [[self alloc] initWithVideoIdentifier:videoIdentifier];
}

#pragma mark - Init

- (instancetype) initWithVideoIdentifier:(NSString *)videoID
{
    if (!(self = [super init]))
		return nil;
    
    self.videoIdentifier = videoID;
    
    return self;
}

#pragma mark - Starting/Stopping Extraction

- (void) startWithCompletionHandler:(XCDYoutubeExtractorCompletionHandler)completionHandler
{
    if (self.completionHandler)
    {
        NSLog(@"Cannot call -[XCDYoutubeExtractor startWithCompletionHandler:] on an extractor which is already extracting");
        NSError *error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:1 userInfo:nil];
        completionHandler(nil, error);
        return;
    }
    
    self.extracting = YES;
    self.completionHandler = completionHandler;
    self.elFields = [[NSMutableArray alloc] initWithArray:@[ @"embedded", @"detailpage", @"vevo", @"" ]];
    [self startVideoInfoRequest];
}

- (void)cancel
{
    [self.connection cancel];
    self.extracting = NO;
}

- (void) startVideoInfoRequest
{
	NSString *elField = [self.elFields objectAtIndex:0];
	[self.elFields removeObjectAtIndex:0];
	if (elField.length > 0)
		elField = [@"&el=" stringByAppendingString:elField];
	
	NSURL *videoInfoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/get_video_info?video_id=%@%@&ps=default&eurl=&gl=US&hl=%@", self.videoIdentifier ?: @"", elField, ApplicationLanguageIdentifier()]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:videoInfoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
	[request setValue:ApplicationLanguageIdentifier() forHTTPHeaderField:@"Accept-Language"];
	[self.connection cancel];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate / NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSUInteger capacity = response.expectedContentLength == NSURLResponseUnknownLength ? 0 : (NSUInteger)response.expectedContentLength;
	self.connectionData = [[NSMutableData alloc] initWithCapacity:capacity];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.connectionData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSError *error = nil;
    NSDictionary *info = [self infoWithData:self.connectionData error:&error];
	if (info)
    {
        self.extracting = NO;
        self.completionHandler(info, nil);
    }
	else if (self.elFields.count > 0)
		[self startVideoInfoRequest];
	else
		[self finishWithError:error];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self finishWithError:error];
}

- (void) finishWithError:(NSError *)error
{
    self.extracting = NO;
	self.completionHandler(nil, error);
}

#pragma mark - URL Parsing

- (NSDictionary *) infoWithData:(NSData *)data error:(NSError * __autoreleasing *)error
{
	NSString *videoQuery = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSStringEncoding queryEncoding = NSUTF8StringEncoding;
	NSDictionary *video = DictionaryWithQueryString(videoQuery, queryEncoding);
	NSArray *streamQueries = [video[@"url_encoded_fmt_stream_map"] componentsSeparatedByString:@","];
	
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	for (NSString *streamQuery in streamQueries)
	{
		NSDictionary *stream = DictionaryWithQueryString(streamQuery, queryEncoding);
		NSString *type = stream[@"type"];
		NSString *urlString = stream[@"url"];
		NSString *signature = stream[@"sig"];
		if (urlString && signature && [AVURLAsset isPlayableExtendedMIMEType:type])
		{
			NSURL *streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", urlString, signature]];
			streamURLs[@([stream[@"itag"] integerValue])] = streamURL;
		}
	}
    
    NSMutableDictionary *info = [NSMutableDictionary new];
	
	for (NSNumber *videoQuality in streamURLs)
	{
		NSURL *streamURL = streamURLs[videoQuality];
		if (streamURL)
		{
            info[videoQuality] = streamURL;
            
			NSString *title = video[@"title"];
			NSString *thumbnailSmall = video[@"thumbnail_url"];
			NSString *thumbnailMedium = video[@"iurlsd"];
			NSString *thumbnailLarge = video[@"iurlmaxres"];
			if (title)
				info[XCDMetadataKeyTitle] = title;
			if (thumbnailSmall)
				info[XCDMetadataKeySmallThumbnailURL] = [NSURL URLWithString:thumbnailSmall];
			if (thumbnailMedium)
				info[XCDMetadataKeyMediumThumbnailURL] = [NSURL URLWithString:thumbnailMedium];
			if (thumbnailLarge)
				info[XCDMetadataKeyLargeThumbnailURL] = [NSURL URLWithString:thumbnailLarge];
		}
	}
    
    if ([info count] != 0)
    {
        return info;
    }
	
	if (error)
	{
		NSMutableDictionary *userInfo = [@{ NSURLErrorKey: self.connection.originalRequest.URL } mutableCopy];
		NSString *reason = video[@"reason"];
		if (reason)
		{
			reason = [reason stringByReplacingOccurrencesOfString:@"<br\\s*/?>" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, reason.length)];
			NSRange range;
			while ((range = [reason rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
				reason = [reason stringByReplacingCharactersInRange:range withString:@""];
			
			userInfo[NSLocalizedDescriptionKey] = reason;
		}
		
		NSInteger code = [video[@"errorcode"] integerValue];
		*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:code userInfo:userInfo];
	}
	
	return nil;
}

@end

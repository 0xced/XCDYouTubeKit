//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideo+Private.h"

#import "XCDYouTubeError.h"

NSString *const XCDYouTubeVideoErrorDomain = @"XCDYouTubeVideoErrorDomain";

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

@implementation XCDYouTubeVideo

- (instancetype) initWithIdentifier:(NSString *)identifier response:(NSURLResponse *)response data:(NSData *)data error:(NSError * __autoreleasing *)error
{
	if (!(self = [super init]))
		return nil;
	
	_identifier = identifier;
	
	NSString *videoQuery = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSStringEncoding queryEncoding = NSUTF8StringEncoding;
	NSDictionary *video = DictionaryWithQueryString(videoQuery, queryEncoding);
	
	if ([video[@"status"] isEqualToString:@"ok"])
	{
		NSMutableArray *streamQueries = [[video[@"url_encoded_fmt_stream_map"] componentsSeparatedByString:@","] mutableCopy];
		[streamQueries addObjectsFromArray:[video[@"adaptive_fmts"] componentsSeparatedByString:@","]];
		
		_title = video[@"title"];
		
		NSString *smallThumbnail = video[@"thumbnail_url"];
		NSString *mediumThumbnail = video[@"iurlsd"] ?: video[@"iurl"];
		NSString *largeThumbnail = video[@"iurlmaxres"];
		_smallThumbnailURL = smallThumbnail ? [NSURL URLWithString:smallThumbnail] : nil;
		_mediumThumbnailURL = mediumThumbnail ? [NSURL URLWithString:mediumThumbnail] : nil;
		_largeThumbnailURL = largeThumbnail ? [NSURL URLWithString:largeThumbnail] : nil;
		
		NSMutableDictionary *streamURLs = [NSMutableDictionary new];
		for (NSString *streamQuery in streamQueries)
		{
			NSDictionary *stream = DictionaryWithQueryString(streamQuery, queryEncoding);
			NSString *urlString = stream[@"url"];
			if (urlString)
			{
				NSURL *streamURL = [NSURL URLWithString:urlString];
				NSString *signature = stream[@"sig"];
				if (signature)
					streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", urlString, signature]];
				
				if ([[DictionaryWithQueryString(streamURL.query, queryEncoding) allKeys] containsObject:@"signature"])
					streamURLs[@([stream[@"itag"] integerValue])] = streamURL;
			}
		}
		_streamURLs = [streamURLs copy];
		return self;
	}
	else
	{
		if (error)
		{
			NSMutableDictionary *userInfo = response.URL ? [@{ NSURLErrorKey: response.URL } mutableCopy] : [NSMutableDictionary new];
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
}

#pragma mark - NSObject

- (NSString *) debugDescription
{
	return [NSString stringWithFormat:@"<%@: %p> [%@] %@\n%@", self.class, self, self.identifier, self.title, self.streamURLs];
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
	return self;
}

@end

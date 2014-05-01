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
	
	NSMutableDictionary *userInfo = response.URL ? [@{ NSURLErrorKey: response.URL } mutableCopy] : [NSMutableDictionary new];
	
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
			NSString *itag = stream[@"itag"];
			if (urlString && itag)
				streamURLs[@([itag integerValue])] = [NSURL URLWithString:urlString];
		}
		_streamURLs = [streamURLs copy];
		
		if (_streamURLs.count == 0)
		{
			if (error)
				*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNoStreamAvailable userInfo:userInfo];
			
			return nil;
		}
		
		return self;
	}
	else
	{
		if (error)
		{
			NSString *reason = video[@"reason"];
			if (reason)
			{
				reason = [reason stringByReplacingOccurrencesOfString:@"<br\\s*/?>" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, reason.length)];
				NSRange range;
				while ((range = [reason rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
					reason = [reason stringByReplacingCharactersInRange:range withString:@""];
				
				userInfo[NSLocalizedDescriptionKey] = reason;
			}
			
			NSString *errorcode = video[@"errorcode"];
			NSInteger code = errorcode ? [errorcode integerValue] : XCDYouTubeErrorNoStreamAvailable;
			*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:code userInfo:userInfo];
		}
		return nil;
	}
}

#pragma mark - NSObject

- (BOOL) isEqual:(id)object
{
	return [object isKindOfClass:[XCDYouTubeVideo class]] ? [((XCDYouTubeVideo *)object).identifier isEqual:self.identifier] : NO;
}

- (NSUInteger) hash
{
	return [self.identifier hash];
}

- (NSString *) description
{
	return self.title;
}

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

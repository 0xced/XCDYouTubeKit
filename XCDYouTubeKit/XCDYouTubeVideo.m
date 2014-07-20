//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideo+Private.h"

#import "XCDYouTubeError.h"

#import <objc/runtime.h>

NSString *const XCDYouTubeVideoErrorDomain = @"XCDYouTubeVideoErrorDomain";
NSString *const XCDYouTubeNoStreamVideoUserInfoKey = @"NoStreamVideo";
NSString *const XCDYouTubeVideoQualityHTTPLiveStreaming = @"HTTPLiveStreaming";

NSDictionary *XCDDictionaryWithQueryString(NSString *string, NSStringEncoding encoding)
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
	return [dictionary copy];
}

static NSString *XCDURLEncodedStringUsingEncoding(NSString *string, NSStringEncoding encoding)
{
	return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), CFStringConvertNSStringEncodingToEncoding(encoding)));
}

NSString *XCDQueryStringWithDictionary(NSDictionary *dictionary, NSStringEncoding encoding)
{
	NSArray *keys = [[dictionary allKeys] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return [evaluatedObject isKindOfClass:[NSString class]];
	}]];
	
	NSMutableString *query = [NSMutableString new];
	for (NSString *key in [keys sortedArrayUsingSelector:@selector(compare:)])
	{
		if (query.length > 0)
			[query appendString:@"&"];
		
		[query appendString:XCDURLEncodedStringUsingEncoding(key, encoding)];
		[query appendString:@"="];
		[query appendString:XCDURLEncodedStringUsingEncoding([dictionary[key] description], encoding)];
	}
	return [query copy];
}

@implementation XCDYouTubeVideo

- (instancetype) initWithIdentifier:(NSString *)identifier info:(NSDictionary *)info playerScript:(XCDYouTubePlayerScript *)playerScript response:(NSURLResponse *)response error:(NSError * __autoreleasing *)error
{
	if (!(self = [super init]))
		return nil;
	
	_identifier = identifier;

	NSString *streamMap = info[@"url_encoded_fmt_stream_map"];
	NSString *httpLiveStream = info[@"hlsvp"];
	NSString *adaptiveFormats = info[@"adaptive_fmts"];
	
	NSMutableDictionary *userInfo = response.URL ? [@{ NSURLErrorKey: response.URL } mutableCopy] : [NSMutableDictionary new];
	
	if (streamMap.length > 0 || httpLiveStream.length > 0)
	{
		NSMutableArray *streamQueries = [[streamMap componentsSeparatedByString:@","] mutableCopy];
		[streamQueries addObjectsFromArray:[adaptiveFormats componentsSeparatedByString:@","]];
		
		_title = info[@"title"];
		_duration = [info[@"length_seconds"] doubleValue];
		
		NSString *smallThumbnail = info[@"thumbnail_url"] ?: info[@"iurl"];
		NSString *mediumThumbnail = info[@"iurlsd"] ?: info[@"iurlhq"] ?: info[@"iurlmq"];
		NSString *largeThumbnail = info[@"iurlmaxres"];
		_smallThumbnailURL = smallThumbnail ? [NSURL URLWithString:smallThumbnail] : nil;
		_mediumThumbnailURL = mediumThumbnail ? [NSURL URLWithString:mediumThumbnail] : nil;
		_largeThumbnailURL = largeThumbnail ? [NSURL URLWithString:largeThumbnail] : nil;
		
		NSString *useCipherSignature = info[@"use_cipher_signature"];
		if ([useCipherSignature boolValue] && !playerScript)
		{
			userInfo[XCDYouTubeNoStreamVideoUserInfoKey] = self;
			if (error)
				*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorUseCipherSignature userInfo:userInfo];
			
			return nil;
		}
		
		NSMutableDictionary *streamURLs = [NSMutableDictionary new];
		
		if (httpLiveStream)
			streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] = [NSURL URLWithString:httpLiveStream];
		
		for (NSString *streamQuery in streamQueries)
		{
			NSDictionary *stream = XCDDictionaryWithQueryString(streamQuery, NSUTF8StringEncoding);
			
			NSString *scrambledSignature = stream[@"s"];
			NSString *signature = [playerScript unscrambleSignature:scrambledSignature];
			if (playerScript && !signature)
				continue;
			
			NSString *urlString = stream[@"url"];
			NSString *itag = stream[@"itag"];
			if (urlString && itag)
			{
				NSURL *streamURL = [NSURL URLWithString:urlString];
				if (signature)
					streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", urlString, [signature stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
				
				streamURLs[@([itag integerValue])] = streamURL;
			}
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
			NSString *reason = info[@"reason"];
			if (reason)
			{
				reason = [reason stringByReplacingOccurrencesOfString:@"<br\\s*/?>" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, reason.length)];
				reason = [reason stringByReplacingOccurrencesOfString:@"\n" withString:@" " options:(NSStringCompareOptions)0 range:NSMakeRange(0, reason.length)];
				NSRange range;
				while ((range = [reason rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
					reason = [reason stringByReplacingCharactersInRange:range withString:@""];
				
				userInfo[NSLocalizedDescriptionKey] = reason;
			}
			
			NSString *errorcode = info[@"errorcode"];
			NSInteger code = errorcode ? [errorcode integerValue] : XCDYouTubeErrorNoStreamAvailable;
			*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:code userInfo:userInfo];
		}
		return nil;
	}
}

- (void) mergeVideo:(XCDYouTubeVideo *)video
{
	unsigned int count;
	objc_property_t *properties = class_copyPropertyList(self.class, &count);
	for (unsigned int i = 0; i < count; i++)
	{
		NSString *propertyName = @(property_getName(properties[i]));
		if (![self valueForKey:propertyName])
			[self setValue:[video valueForKey:propertyName] forKeyPath:propertyName];
	}
	free(properties);
}

#pragma mark - NSObject

- (BOOL) isEqual:(id)object
{
	return [object isKindOfClass:[XCDYouTubeVideo class]] && [((XCDYouTubeVideo *)object).identifier isEqual:self.identifier];
}

- (NSUInteger) hash
{
	return [self.identifier hash];
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"[%@] %@", self.identifier, self.title];
}

- (NSString *) debugDescription
{
	NSString *thumbnailDescription = [NSString stringWithFormat:@"Small  thumbnail: %@\nMedium thumbnail: %@\nLarge  thumbnail: %@", self.smallThumbnailURL, self.mediumThumbnailURL, self.largeThumbnailURL];
	return [NSString stringWithFormat:@"<%@: %p> %@\nDuration: %@ seconds\n%@\nVideo Streams: %@", self.class, self, self.description, @(self.duration), thumbnailDescription, self.streamURLs];
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
	return self;
}

@end

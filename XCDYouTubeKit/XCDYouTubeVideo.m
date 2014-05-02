//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideo+Private.h"

#import "XCDYouTubeError.h"

NSString *const XCDYouTubeVideoErrorDomain = @"XCDYouTubeVideoErrorDomain";

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
	return dictionary;
}

@implementation XCDYouTubeVideo

- (instancetype) initWithIdentifier:(NSString *)identifier info:(NSDictionary *)info signatureFunction:(JSValue *)signatureFunction response:(NSURLResponse *)response error:(NSError * __autoreleasing *)error
{
	if (!(self = [super init]))
		return nil;
	
	_identifier = identifier;

	NSString *streamMap = info[@"url_encoded_fmt_stream_map"];
	NSString *adaptiveFormats = info[@"adaptive_fmts"];
	
	NSMutableDictionary *userInfo = response.URL ? [@{ NSURLErrorKey: response.URL } mutableCopy] : [NSMutableDictionary new];
	
	if (streamMap)
	{
		NSString *useCipherSignature = info[@"use_cipher_signature"];
		if ([useCipherSignature respondsToSelector:@selector(boolValue)] && [useCipherSignature boolValue] && !signatureFunction)
		{
			if (error)
				*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorUseCipherSignature userInfo:userInfo];
			
			return nil;
		}
		
		NSMutableArray *streamQueries = [[streamMap componentsSeparatedByString:@","] mutableCopy];
		[streamQueries addObjectsFromArray:[adaptiveFormats componentsSeparatedByString:@","]];
		
		_title = info[@"title"];
		
		NSString *smallThumbnail = info[@"thumbnail_url"];
		NSString *mediumThumbnail = info[@"iurlsd"] ?: info[@"iurl"];
		NSString *largeThumbnail = info[@"iurlmaxres"];
		_smallThumbnailURL = smallThumbnail ? [NSURL URLWithString:smallThumbnail] : nil;
		_mediumThumbnailURL = mediumThumbnail ? [NSURL URLWithString:mediumThumbnail] : nil;
		_largeThumbnailURL = largeThumbnail ? [NSURL URLWithString:largeThumbnail] : nil;
		
		NSMutableDictionary *streamURLs = [NSMutableDictionary new];
		for (NSString *streamQuery in streamQueries)
		{
			NSDictionary *stream = XCDDictionaryWithQueryString(streamQuery, NSUTF8StringEncoding);
			
			NSString *signature = nil;
			NSString *scrambledSignature = stream[@"s"];
			if (signatureFunction && scrambledSignature)
			{
				JSValue *unscrambledSignature = [signatureFunction callWithArguments:@[ scrambledSignature ]];
				if ([unscrambledSignature isString])
					signature = [unscrambledSignature toString];
			}
			
			NSString *urlString = stream[@"url"];
			NSString *itag = stream[@"itag"];
			if (urlString && itag)
			{
				NSURL *streamURL = [NSURL URLWithString:urlString];
				if (signature)
					streamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&signature=%@", urlString, signature]];
				
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
	return [NSString stringWithFormat:@"<%@: %p> %@\n%@\nVideo Streams: %@", self.class, self, self.description, thumbnailDescription, self.streamURLs];
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
	return self;
}

@end

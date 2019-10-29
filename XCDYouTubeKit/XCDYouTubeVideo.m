//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideo+Private.h"

#import "XCDYouTubeError.h"
#import "XCDYouTubeLogger+Private.h"

#import <objc/runtime.h>

NSString *const XCDYouTubeVideoErrorDomain = @"XCDYouTubeVideoErrorDomain";
NSString *const XCDYouTubeAllowedCountriesUserInfoKey = @"AllowedCountries";
NSString *const XCDYouTubeNoStreamVideoUserInfoKey = @"NoStreamVideo";
NSString *const XCDYouTubeVideoQualityHTTPLiveStreaming = @"HTTPLiveStreaming";


NSDictionary *XCDStreamingDataWithString(NSString *string)
{
	NSError *error = nil;
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	if (!data) { return nil; }
	NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	
	if (error) { return nil; }
	
	return JSON[@"streamingData"];
}

NSString *XCDHTTPLiveStreamingStringWithString(NSString *string)
{
	NSDictionary *streamingData = XCDStreamingDataWithString(string);
	NSString *manifestURL = streamingData[@"hlsManifestUrl"];
	if (manifestURL.length == 0) { return nil; }
	
	return manifestURL;
}

NSArray <NSDictionary *> *XCDThumnailArrayWithString(NSString *string)
{
	NSError *error = nil;
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	if (!data) { return nil; }
	NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	
	if (error) { return nil; }
	
	NSDictionary *videoDetails = JSON[@"videoDetails"];
	NSDictionary *thumbnail = videoDetails[@"thumbnail"];
	NSArray *thumbnails = thumbnail[@"thumbnails"];
	
	if (thumbnails.count == 0 || thumbnails == nil)  { return nil; }
	return thumbnails;
}

NSArray <NSDictionary *> *XCDCaptionArrayWithString(NSString *string)
{
	NSError *error = nil;
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	if (!data) { return nil; }
	NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	
	if (error) { return nil; }
	
	NSDictionary *captions = JSON[@"captions"];
	NSDictionary *playerCaptionsTracklistRenderer = captions[@"playerCaptionsTracklistRenderer"];
	NSArray *captionTracks = playerCaptionsTracklistRenderer[@"captionTracks"];
	
	if (captionTracks.count == 0 || captionTracks == nil)  { return nil; }
	return captionTracks;
}

NSDictionary *XCDDictionaryWithString(NSString *string)
{
	NSError *error = nil;
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	if (!data) { return nil; }
	
	return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
}

NSDictionary *XCDDictionaryWithQueryString(NSString *string)
{
	NSMutableDictionary *dictionary = [NSMutableDictionary new];
	NSArray *fields = [string componentsSeparatedByString:@"&"];
	for (NSString *field in fields)
	{
		NSArray *pair = [field componentsSeparatedByString:@"="];
		if (pair.count == 2)
		{
			NSString *key = pair[0];
			NSString *value = [(NSString *)pair[1] stringByRemovingPercentEncoding];
			value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
			if (dictionary[key] && ![(NSObject *)dictionary[key] isEqual:value])
			{
				XCDYouTubeLogWarning(@"Using XCDDictionaryWithQueryString is inappropriate because the query string has multiple values for the key '%@'\n"
				                     @"Query: %@\n"
				                     @"Discarded value: %@", key, string, dictionary[key]);
			}
			dictionary[key] = value;
		}
	}
	return [dictionary copy];
}

NSString *XCDQueryStringWithDictionary(NSDictionary *dictionary)
{
	NSArray *keys = [dictionary.allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
		return [(NSObject *)evaluatedObject isKindOfClass:[NSString class]];
	}]];
	
	NSMutableString *query = [NSMutableString new];
	for (NSString *key in [keys sortedArrayUsingSelector:@selector(compare:)])
	{
		if (query.length > 0)
			[query appendString:@"&"];
		
		[query appendFormat:@"%@=%@", key, [(NSObject *)dictionary[key] description]];
	}
	
	return [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

static NSString *SortedDictionaryDescription(NSDictionary *dictionary)
{
	NSArray *sortedKeys = [dictionary.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [[(NSObject *)obj1 description] compare:[(NSObject *) obj2 description] options:NSNumericSearch];
	}];
	
	NSMutableString *description = [[NSMutableString alloc] initWithString:@"{\n"];
	for (id key in sortedKeys)
	{
		[description appendFormat:@"\t%@ \u2192 %@\n", key, dictionary[key]];
	}
	[description appendString:@"}"];
	
	return [description copy];
}

static NSURL * URLBySettingParameter(NSURL *URL, NSString *key, NSString *percentEncodedValue)
{
	NSString *pattern = [NSString stringWithFormat:@"((?:^|&)%@=)[^&]*", key];
	NSString *template = [NSString stringWithFormat:@"$1%@", percentEncodedValue];
	NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
	NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:(NSRegularExpressionOptions)0 error:NULL];
	NSMutableString *percentEncodedQuery = [components.percentEncodedQuery ?: @"" mutableCopy];
	NSUInteger numberOfMatches = [regularExpression replaceMatchesInString:percentEncodedQuery options:(NSMatchingOptions)0 range:NSMakeRange(0, percentEncodedQuery.length) withTemplate:template];
	if (numberOfMatches == 0)
		[percentEncodedQuery appendFormat:@"%@%@=%@", percentEncodedQuery.length > 0 ? @"&" : @"", key, percentEncodedValue];
	components.percentEncodedQuery = percentEncodedQuery;
	return components.URL;
}

@implementation XCDYouTubeVideo

static NSDate * ExpirationDate(NSURL *streamURL)
{
	NSDictionary *query = XCDDictionaryWithQueryString(streamURL.query);
	NSTimeInterval expire = [(NSString *)query[@"expire"] doubleValue];
	return expire > 0 ? [NSDate dateWithTimeIntervalSince1970:expire] : nil;
}

- (instancetype) initWithIdentifier:(NSString *)identifier info:(NSDictionary *)info playerScript:(XCDYouTubePlayerScript *)playerScript response:(NSURLResponse *)response error:(NSError * __autoreleasing *)error
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	_identifier = identifier;
	
	NSString *playerResponse = info[@"player_response"];
	NSString *streamMap = info[@"url_encoded_fmt_stream_map"];
	NSArray *alternativeStreamMap = XCDStreamingDataWithString(playerResponse)[@"formats"];
	NSString *httpLiveStream = info[@"hlsvp"] ?: XCDHTTPLiveStreamingStringWithString(playerResponse);
	NSString *adaptiveFormats = info[@"adaptive_fmts"];
	NSArray *alternativeAdaptiveFormats = XCDStreamingDataWithString(playerResponse)[@"adaptiveFormats"];
	NSDictionary *videoDetails = XCDDictionaryWithString(playerResponse)[@"videoDetails"];
	
	NSMutableDictionary *userInfo = response.URL ? [@{ NSURLErrorKey: (id)response.URL } mutableCopy] : [NSMutableDictionary new];
	
	if (streamMap.length > 0 || httpLiveStream.length > 0 || alternativeStreamMap.count > 0 || alternativeAdaptiveFormats.count > 0)
	{
		NSMutableArray *alternativeStreamQueries = [alternativeStreamMap mutableCopy];
		[alternativeStreamQueries addObjectsFromArray:alternativeAdaptiveFormats];
		
		NSMutableArray *streamQueries = [[streamMap componentsSeparatedByString:@","] mutableCopy];
		[streamQueries addObjectsFromArray:[adaptiveFormats componentsSeparatedByString:@","]];
		
		NSString *title = info[@"title"] == nil? videoDetails[@"title"] : info[@"title"];
		if (title == nil)
			title = @"";
		_title = title;
		
		_duration = info[@"length_seconds"] == nil? [(NSString *)videoDetails[@"lengthSeconds"] doubleValue] : [(NSString *)info[@"length_seconds"] doubleValue];
		
		NSString *thumbnail = info[@"thumbnail_url"] ?: info[@"iurl"];
		_thumbnailURL = thumbnail ? [NSURL URLWithString:thumbnail] : nil;
		
		if (!_thumbnailURL) {
			NSArray <NSDictionary *>*thumnails = XCDThumnailArrayWithString(playerResponse);
			if (thumnails.count >= 1) {
				NSString *thumbnailURLString = thumnails[0][@"url"];
				_thumbnailURL = thumbnailURLString ? [NSURL URLWithString:thumbnailURLString] : nil;
			}
		}
		
		NSMutableDictionary *streamURLs = [NSMutableDictionary new];
		
		if (httpLiveStream)
			streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] = [NSURL URLWithString:httpLiveStream];
		
		NSMutableDictionary *captionURLs = [NSMutableDictionary new];
		NSMutableDictionary *autoGeneratedCaptionURLs = [NSMutableDictionary new];
		
		for (NSDictionary *caption in XCDCaptionArrayWithString(playerResponse))
		{
			NSString *languageCode = caption[@"languageCode"];
			NSString *captionVersion = caption[@"vssId"];
			NSString *captionURLString = caption[@"baseUrl"];
			if (!captionURLString)
			{
				continue;
			}
			NSURL *captionURL = [NSURL URLWithString:captionURLString];
			if (captionURL && languageCode)
				
			{
				if ([languageCode isEqualToString:@"und"])
				{
					//Skip because this is a special code than is used to indicate that the lanauage code is undetermined.
					continue;
				}
				if([captionVersion hasPrefix:@"a"])
				{
					//Indicates the caption was auto generated
					autoGeneratedCaptionURLs[languageCode] = captionURL;
				} else
				{
					captionURLs[languageCode] = captionURL;
				}
			}
		}
		
		if (captionURLs.count > 0)
		{
			_captionURLs = [captionURLs copy];
		}
		
		if (autoGeneratedCaptionURLs.count > 0)
		{
			_autoGeneratedCaptionURLs = [autoGeneratedCaptionURLs copy];
		}
		
		NSError *streamURLsError;
		NSDictionary *mainStreamURLs = [self extractStreamURLsWithQuery:streamQueries.count == 0 ? alternativeStreamQueries : streamQueries playerScript:playerScript userInfo:userInfo error:&streamURLsError];
		if (mainStreamURLs)
			[streamURLs addEntriesFromDictionary:mainStreamURLs];
		
		if (streamURLsError)
		{
			if (error)
				*error = streamURLsError;
			return nil;
		}
		
		_streamURLs = [streamURLs copy];
		
		if (_streamURLs.count == 0)
		{
			if (error)
				*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNoStreamAvailable userInfo:userInfo];
			
			return nil;
		}
		
		for (NSURL *streamURL in _streamURLs.allValues)
		{
			if (!_expirationDate) {
				_expirationDate = ExpirationDate(streamURL);
				break;
			}
		}
		
		_streamURL =  _streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?: _streamURLs[@(XCDYouTubeVideoQualityHD720)] ?: _streamURLs[@(XCDYouTubeVideoQualityMedium360)] ?: _streamURLs[@(XCDYouTubeVideoQualitySmall240)];
		
		return self;
	}
	else
	{
		if (error)
		{
			NSString *reason = info[@"reason"] == nil ? XCDDictionaryWithString(playerResponse)[@"playabilityStatus"][@"reason"] : info[@"reason"];
			if (reason)
			{
				reason = [reason stringByReplacingOccurrencesOfString:@"<br\\s*/?>" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, reason.length)];
				reason = [reason stringByReplacingOccurrencesOfString:@"\n" withString:@" " options:(NSStringCompareOptions)0 range:NSMakeRange(0, reason.length)];
				NSRange range;
				while ((range = [reason rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
					reason = [reason stringByReplacingCharactersInRange:range withString:@""];
				
				userInfo[NSLocalizedDescriptionKey] = reason;
			}
			
			*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorNoStreamAvailable userInfo:userInfo];
		}
		return nil;
	}
}

- (NSDictionary <id, NSURL *>*)extractStreamURLsWithQuery:(NSArray *)streamQueries playerScript:(XCDYouTubePlayerScript *)playerScript userInfo:(NSMutableDictionary *)userInfo error:(NSError *__autoreleasing *)error
{
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];
	
	for (NSObject *streamQuery in streamQueries)
	{
		NSDictionary *stream;
		
		//When using alternative streams the `streamQueries` is an array of NSDictionary's (which are streams)
		if ([streamQuery isKindOfClass:[NSDictionary class]])
		{
			stream = (NSDictionary *)streamQuery;
		}
		else
		{
		    stream = XCDDictionaryWithQueryString((NSString *)streamQuery);
		}
		NSDictionary *alternativeStreamInfo = XCDDictionaryWithQueryString(stream[@"cipher"]);
		NSString *alternativeURLString = alternativeStreamInfo[@"url"];
		
		NSString *scrambledSignature = stream[@"s"] == nil? alternativeStreamInfo[@"s"] : stream[@"s"];
		NSString *spParam = stream[@"sp"] == nil ? alternativeStreamInfo[@"sp"] : stream[@"sp"];
		
		if (scrambledSignature && !playerScript)
		{
			userInfo[XCDYouTubeNoStreamVideoUserInfoKey] = self;
			if (error)
				*error = [NSError errorWithDomain:XCDYouTubeVideoErrorDomain code:XCDYouTubeErrorUseCipherSignature userInfo:userInfo];
			
			return nil;
		}
		NSString *signature = [playerScript unscrambleSignature:scrambledSignature];
		if (playerScript && scrambledSignature && !signature)
			continue;
		
		NSString *urlString = stream[@"url"] == nil ? alternativeURLString : stream[@"url"];
		NSString *itag = stream[@"itag"];
		if (urlString && itag)
		{
			NSURL *streamURL = [NSURL URLWithString:urlString];
			
			if (signature)
			{
				NSString *escapedSignature = [signature stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
				
				if (spParam.length > 0)
				{
					streamURL = URLBySettingParameter(streamURL, spParam, escapedSignature);
					
				} else
				{
					streamURL = URLBySettingParameter(streamURL, @"signature", escapedSignature);
				}
			}
			
			streamURLs[@(itag.integerValue)] = URLBySettingParameter(streamURL, @"ratebypass", @"yes");
		}
	}
	
	return streamURLs.copy;
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

- (void) mergeDashManifestStreamURLs:(NSDictionary *)dashManifestStreamURLs {
	
	NSMutableDictionary *approvedStreams = [NSMutableDictionary new];
	
	for (NSString *itag in dashManifestStreamURLs) {
		if (self.streamURLs[itag] == nil)
			approvedStreams[itag] = dashManifestStreamURLs[itag];
	}
	
	NSMutableDictionary *newStreams = [NSMutableDictionary dictionaryWithDictionary:self.streamURLs];
	[newStreams addEntriesFromDictionary:approvedStreams];
	[self setValue:newStreams.copy forKeyPath:NSStringFromSelector(@selector(streamURLs))];
}

#pragma mark - NSObject

- (BOOL) isEqual:(id)object
{
	return [(NSObject *)object isKindOfClass:[XCDYouTubeVideo class]] && [((XCDYouTubeVideo *)object).identifier isEqual:self.identifier];
}

- (NSUInteger) hash
{
	return self.identifier.hash;
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"[%@] %@", self.identifier, self.title];
}

- (NSString *) debugDescription
{
	NSDateComponentsFormatter *dateComponentsFormatter = [NSDateComponentsFormatter new];
	dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
	NSString *duration = [dateComponentsFormatter stringFromTimeInterval:self.duration] ?: [NSString stringWithFormat:@"%@ seconds", @(self.duration)];
	NSString *thumbnailDescription = [NSString stringWithFormat:@"Thumbnail: %@", self.thumbnailURL];
	NSString *streamsDescription = SortedDictionaryDescription(self.streamURLs);
	return [NSString stringWithFormat:@"<%@: %p> %@\nDuration: %@\nExpiration date: %@\n%@\nStreams: %@", self.class, self, self.description, duration, self.expirationDate, thumbnailDescription, streamsDescription];
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
	return self;
}

@end

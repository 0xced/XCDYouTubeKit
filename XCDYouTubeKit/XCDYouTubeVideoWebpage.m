//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoWebpage.h"

#import "XCDYouTubeLogger.h"

@interface XCDYouTubeVideoWebpage ()
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSURLResponse *response;
@end

@implementation XCDYouTubeVideoWebpage
{
	NSDictionary *_playerConfiguration;
	NSDictionary *_videoInfo;
	NSURL *_javaScriptPlayerURL;
	BOOL _isAgeRestricted;
}

- (instancetype) initWithData:(NSData *)data response:(NSURLResponse *)response
{
	if (!(self = [super init]))
		return nil;
	
	_data = data;
	_response = response;
	
	return self;
}

#pragma clang diagnostic ignored "-Wdirect-ivar-access"

- (NSDictionary *) playerConfiguration
{
	if (!_playerConfiguration)
	{
		__block NSDictionary *playerConfigurationDictionary;
		CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)self.response.textEncodingName ?: CFSTR(""));
		NSString *html = CFBridgingRelease(CFStringCreateWithBytes(kCFAllocatorDefault, self.data.bytes, (CFIndex)self.data.length, encoding != kCFStringEncodingInvalidId ? encoding : kCFStringEncodingISOLatin1, false));
		XCDYouTubeLogTrace(@"%@", html);
		NSRegularExpression *playerConfigRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"ytplayer.config\\s*=\\s*(\\{.*?\\});|\\(\\s*'PLAYER_CONFIG',\\s*(\\{.*?\\})\\s*\\)" options:NSRegularExpressionCaseInsensitive error:NULL];
		[playerConfigRegularExpression enumerateMatchesInString:html options:(NSMatchingOptions)0 range:NSMakeRange(0, html.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
		{
			for (NSUInteger i = 1; i < result.numberOfRanges; i++)
			{
				NSRange range = [result rangeAtIndex:i];
				if (range.length == 0)
					continue;
				
				NSString *configString = [html substringWithRange:range];
				NSDictionary *playerConfiguration = [NSJSONSerialization JSONObjectWithData:[configString dataUsingEncoding:NSUTF8StringEncoding] options:(NSJSONReadingOptions)0 error:NULL];
				if ([playerConfiguration isKindOfClass:[NSDictionary class]])
				{
					playerConfigurationDictionary = playerConfiguration;
					*stop = YES;
				}
			}
		}];
		_playerConfiguration = playerConfigurationDictionary;
	}
	return _playerConfiguration;
}

- (NSDictionary *) videoInfo
{
	if (!_videoInfo)
	{
		NSDictionary *args = self.playerConfiguration[@"args"];
		if ([args isKindOfClass:[NSDictionary class]])
		{
			NSMutableDictionary *info = [NSMutableDictionary new];
			[args enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop)
			{
				if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
					info[key] = [value description];
			}];
			_videoInfo = [info copy];
		}
	}
	return _videoInfo;
}

- (NSURL *) javaScriptPlayerURL
{
	if (!_javaScriptPlayerURL)
	{
		NSString *jsAssets = [self.playerConfiguration valueForKeyPath:@"assets.js"];
		if ([jsAssets isKindOfClass:[NSString class]])
		{
			NSString *javaScriptPlayerURLString = jsAssets;
			if ([jsAssets hasPrefix:@"//"])
				javaScriptPlayerURLString = [@"https:" stringByAppendingString:jsAssets];
			
			_javaScriptPlayerURL = [NSURL URLWithString:javaScriptPlayerURLString];
		}
	}
	return _javaScriptPlayerURL;
}

- (BOOL) isAgeRestricted
{
	if (!_isAgeRestricted)
	{
		NSData *openGraphAgeRestriction = [@"og:restrictions:age" dataUsingEncoding:NSUTF8StringEncoding];
		NSDataSearchOptions options = (NSDataSearchOptions)0;
		NSRange range = NSMakeRange(0, self.data.length);
		_isAgeRestricted = [self.data rangeOfData:openGraphAgeRestriction options:options range:range].location != NSNotFound;
	}
	return _isAgeRestricted;
}

@end

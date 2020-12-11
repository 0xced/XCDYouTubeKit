//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeVideoWebpage.h"

@interface XCDYouTubeVideoWebpage ()
@property (nonatomic, readonly) NSString *html;
@property (nonatomic, readonly) NSDictionary *playerContextConfiguration;
@end

@implementation XCDYouTubeVideoWebpage

@synthesize playerConfiguration = _playerConfiguration;
@synthesize playerContextConfiguration = _playerContextConfiguration;
@synthesize videoInfo = _videoInfo;
@synthesize sts = _sts;
@synthesize javaScriptPlayerURL = _javaScriptPlayerURL;
@synthesize isAgeRestricted = _isAgeRestricted;
@synthesize regionsAllowed = _regionsAllowed;

- (instancetype) initWithHTMLString:(NSString *)html
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	_html = html;
	
	return self;
}

- (NSDictionary *) playerConfiguration
{
	if (!_playerConfiguration)
	{
		NSArray<NSString *>*patterns = @[@";ytplayer\\.config\\s*=\\s*(\\{.+?\\});ytplayer", @";ytplayer\\.config\\s*=\\s*(\\{.+?\\});"];
		for (NSString *pattern in patterns) {
			NSDictionary *configuration = XCDPlayerConfigurationWithString(self.html, pattern);
			if (configuration != nil)
			{
				_playerConfiguration = configuration;
				break;
			}
		}
	}
	return _playerConfiguration;
}

static NSDictionary *XCDPlayerConfigurationWithString(NSString *html, NSString *regularExpressionPattern)
{
	__block NSDictionary *playerConfigurationDictionary;
	NSRegularExpression *playerConfigRegularExpression = [NSRegularExpression regularExpressionWithPattern:regularExpressionPattern options:NSRegularExpressionCaseInsensitive error:NULL];
	[playerConfigRegularExpression enumerateMatchesInString:html options:(NSMatchingOptions)0 range:NSMakeRange(0, html.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
	{
		for (NSUInteger i = 1; i < result.numberOfRanges; i++)
		{
			NSRange range = [result rangeAtIndex:i];
			if (range.length == 0)
				continue;
			
			NSString *configString = [html substringWithRange:range];
			NSData *configData = [configString dataUsingEncoding:NSUTF8StringEncoding];
			NSDictionary *playerConfiguration = [NSJSONSerialization JSONObjectWithData:configData ?: [NSData new] options:(NSJSONReadingOptions)0 error:NULL];
			if ([playerConfiguration isKindOfClass:[NSDictionary class]])
			{
				playerConfigurationDictionary = playerConfiguration;
				*stop = YES;
			}
		}
	}];
	
	return  playerConfigurationDictionary;
}

- (NSDictionary *) videoInfo
{
	if (!_videoInfo)
	{
		NSDictionary *args = self.playerConfiguration[@"args"];
		if (args == nil)
		{
			_videoInfo = XCDPlayerConfigurationWithString(self.html, @"ytInitialPlayerResponse\\s*=\\s*(\\{.+?\\})\\s*;");
			return _videoInfo;
		}
		if ([args isKindOfClass:[NSDictionary class]])
		{
			NSMutableDictionary *info = [NSMutableDictionary new];
			[args enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop)
			{
				if ([(NSObject *)value isKindOfClass:[NSString class]] || [(NSObject *)value isKindOfClass:[NSNumber class]])
					info[key] = [(NSObject *)value description];
			}];
			_videoInfo = [info copy];
		}
	}
	return _videoInfo;
}

- (NSString *)sts
{
	if (!_sts)
	{
		NSString *sts = [(NSString *)self.playerConfiguration[@"sts"] description];
		if (sts != nil) {
			_sts = sts;
			return _sts;
		} else {
			NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\"sts\"\\s*:\\s*(\\d+)" options:0 error:nil];
			NSTextCheckingResult *result = [regex firstMatchInString:self.html options:(NSMatchingOptions)0 range:NSMakeRange(0, self.html.length)];
			if (result.numberOfRanges < 2)
				return _sts;
			
			NSRange range = [result rangeAtIndex:1];
			if (range.length == 0)
				return _sts;
			
			_sts = [self.html substringWithRange:range];
		}
	}
	
	return _sts;
}

static NSURL *XCDJavaScriptPlayerURLFromString(NSString *javaScriptString)
{
	NSString *javaScriptPlayerURLString = javaScriptString;
	if ([javaScriptString hasPrefix:@"//"])
		javaScriptPlayerURLString = [@"https:" stringByAppendingString:javaScriptString];
	else if ([javaScriptString hasPrefix:@"/"])
		javaScriptPlayerURLString = [@"https://www.youtube.com" stringByAppendingString:javaScriptString];
	
	return [NSURL URLWithString:javaScriptPlayerURLString];
}

- (NSURL *) javaScriptPlayerURL
{
	if (!_javaScriptPlayerURL)
	{
		NSString *jsAssets = [self.playerConfiguration valueForKeyPath:@"assets.js"];
		if ([jsAssets isKindOfClass:[NSString class]])
		{
			_javaScriptPlayerURL = XCDJavaScriptPlayerURLFromString(jsAssets);
		}
		else
		{
			NSArray<NSString *>*patterns = @[@"<script[^>]+\\bsrc=(\"[^\"]+\")[^>]+\\bname=[\"\\\']player_ias/base", @"jsUrl\"\\s*:\\s*(\"[^\"]+\")", @"\"assets\":.+?\"js\":\\s*(\"[^\"]+\")"];
			for (NSString *pattern in patterns)
			{
				NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
				NSTextCheckingResult *result = [regex firstMatchInString:self.html options:(NSMatchingOptions)0 range:NSMakeRange(0, self.html.length)];
				if (result.numberOfRanges < 2)
				{
					continue;
				}
				
				NSRange range = [result rangeAtIndex:1];
				if (range.length == 0)
				{
					continue;
				}
				
				NSString *baseURLString = [[[self.html substringWithRange:range] stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
				NSURL *javaScriptPlayerURL = XCDJavaScriptPlayerURLFromString(baseURLString);
				if (javaScriptPlayerURL != nil)
				{
					_javaScriptPlayerURL = javaScriptPlayerURL;
					break;
				}
				
			}
		}
	}
	return _javaScriptPlayerURL;
}

- (BOOL) isAgeRestricted
{
	if (!_isAgeRestricted)
	{
		NSStringCompareOptions options = (NSStringCompareOptions)0;
		NSRange range = NSMakeRange(0, self.html.length);
		_isAgeRestricted = [self.html rangeOfString:@"og:restrictions:age" options:options range:range].location != NSNotFound || [self.html rangeOfString:@"player-age-gate-content" options:options range:range].location != NSNotFound;

	}
	return _isAgeRestricted;
}

- (NSSet *) regionsAllowed
{
	if (!_regionsAllowed)
	{
		_regionsAllowed = [NSSet set];
		NSRegularExpression *regionsAllowedRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"meta\\s+itemprop=\"regionsAllowed\"\\s+content=\"(.*)\"" options:(NSRegularExpressionOptions)0 error:NULL];
		NSTextCheckingResult *regionsAllowedResult = [regionsAllowedRegularExpression firstMatchInString:self.html options:(NSMatchingOptions)0 range:NSMakeRange(0, self.html.length)];
		if (regionsAllowedResult.numberOfRanges > 1)
		{
			NSString *regionsAllowed = [self.html substringWithRange:[regionsAllowedResult rangeAtIndex:1]];
			if (regionsAllowed.length > 0)
				_regionsAllowed = [NSSet setWithArray:[regionsAllowed componentsSeparatedByString:@","]];
		}
	}
	return _regionsAllowed;
}

@end

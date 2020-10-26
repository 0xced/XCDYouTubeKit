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
		_playerConfiguration = XCDPlayerConfigurationWithString(self.html, @"ytplayer.config\\s*=\\s*(\\{.*?\\});|[\\({]\\s*'PLAYER_CONFIG'[,:]\\s*(\\{.*?\\})\\s*(?:,'|\\))");
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

- (NSDictionary *) playerContextConfiguration
{
	if (!_playerContextConfiguration)
	{
		_playerContextConfiguration = XCDPlayerConfigurationWithString(self.html, @"ytplayer.web_player_context_config\\s*=\\s(\\{[^;]*)");
	}
	return _playerContextConfiguration;
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
static NSRange XCDJavaScriptAssetsRange(NSString *html)
{
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\"assets\":.+?\"js\":\\s*(\"[^\"]+\")" options:0 error:nil];
	NSTextCheckingResult *result = [regex firstMatchInString:html options:(NSMatchingOptions)0 range:NSMakeRange(0, html.length)];
	if (result.numberOfRanges < 2)
		return NSMakeRange(0, 0);
	NSRange range = [result rangeAtIndex:1];
	if (range.length == 0)
		return NSMakeRange(0, 0);
	
	return range;
}
- (NSURL *) javaScriptPlayerURL
{
	if (!_javaScriptPlayerURL)
	{
		NSRange jsAssetsRange = XCDJavaScriptAssetsRange(self.html);
		NSString *jsAssets = [self.playerConfiguration valueForKeyPath:@"assets.js"];
		if ([jsAssets isKindOfClass:[NSString class]])
		{
			_javaScriptPlayerURL = XCDJavaScriptPlayerURLFromString(jsAssets);
		}
		else if (jsAssetsRange.length != 0)
		{
			NSString *baseJSURLPathString = [[[self.html substringWithRange:jsAssetsRange] stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
			
			NSURLComponents *components = [NSURLComponents componentsWithString:baseJSURLPathString];
			if (components == nil)
				return _javaScriptPlayerURL;
			
			if (components.scheme == nil || components.scheme.length == 0)
				components.scheme = @"https";
			
			if (components.host == nil || components.host.length == 0)
				components.host = @"www.youtube.com";
			
			if (components.URL == nil)
				return _javaScriptPlayerURL;
			
			_javaScriptPlayerURL = components.URL;
		}
		else if (self.playerContextConfiguration[@"jsUrl"])
		{
			_javaScriptPlayerURL = XCDJavaScriptPlayerURLFromString(self.playerContextConfiguration[@"jsUrl"]);
		}
		else
		{
			//Fallback I noticed that `jsUrl` seems to always be present on videos that require the javascript page
			//Because this is a very broad regex search it might catch things in the future that it shoudn't.
			NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"jsUrl\":\\s*\"([^\"]*)" options:0 error:nil];
			NSTextCheckingResult *result = [regex firstMatchInString:self.html options:(NSMatchingOptions)0 range:NSMakeRange(0, self.html.length)];
			if (result.numberOfRanges < 2)
				return _javaScriptPlayerURL;
			NSRange range = [result rangeAtIndex:1];
			if (range.length == 0)
				return _javaScriptPlayerURL;
			
			NSString *javaScriptPlayerURL = [self.html substringWithRange:range];
			_javaScriptPlayerURL = XCDJavaScriptPlayerURLFromString(javaScriptPlayerURL);
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

//
//  Copyright (c) 2013-2016 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubePlayerScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "XCDYouTubeLogger+Private.h"

@interface XCDYouTubePlayerScript ()
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) JSValue *signatureFunction;
@end

@implementation XCDYouTubePlayerScript

- (instancetype) initWithString:(NSString *)string customPatterns:(NSArray<NSString *> *)customPatterns
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	_context = [JSContext new];
	
	_context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
		XCDYouTubeLogWarning(@"JavaScript exception: %@", exception);
	};
	
	NSDictionary *environment = @{
		@"document": @{
			@"documentElement": @{}
		},
		@"location": @{
			@"hash": @""
		},
		@"navigator": @{
			@"userAgent": @""
		},
	};
	_context[@"window"] = @{};
	_context [@"XMLHttpRequest"] = @{};
	
	for (NSString *propertyName in environment)
	{
		JSValue *value = [JSValue valueWithObject:environment[propertyName] inContext:_context];
		_context[propertyName] = value;
		_context[@"window"][propertyName] = value;
	}
	
	NSString *matchMediaJsFunction = @"var matchMediaWindow=this;matchMediaWindow.matchMedia=function(a){return false;};";
	NSString *script = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	script=[matchMediaJsFunction stringByAppendingString:(script)];
	[_context evaluateScript:script];
	
	NSRegularExpression *anonymousFunctionRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\(function\\(([^)]*)\\)\\{(.*)\\}\\)\\(([^)]*)\\)" options:NSRegularExpressionDotMatchesLineSeparators error:NULL];
	NSTextCheckingResult *anonymousFunctionResult = [anonymousFunctionRegularExpression firstMatchInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length)];
	if (anonymousFunctionResult.numberOfRanges > 3)
	{
		NSArray *parameters = [[script substringWithRange:[anonymousFunctionResult rangeAtIndex:1]] componentsSeparatedByString:@","];
		NSArray *arguments = [[script substringWithRange:[anonymousFunctionResult rangeAtIndex:3]] componentsSeparatedByString:@","];
		if (parameters.count == arguments.count)
		{
			for (NSUInteger i = 0; i < parameters.count; i++)
			{
				_context[parameters[i]] = _context[arguments[i]];
			}
		}
		NSString *anonymousFunctionBody = [script substringWithRange:[anonymousFunctionResult rangeAtIndex:2]];
		[_context evaluateScript:anonymousFunctionBody];
	}
	else
	{
		XCDYouTubeLogWarning(@"Unexpected player script (no anonymous function found)");
	}

	//See list of regex patterns here https://github.com/ytdl-org/youtube-dl/blob/master/youtube_dl/extractor/youtube.py#L1344
	NSArray<NSString *>*hardCodedPatterns = @[
		@"\\b[cs]\\s*&&\\s*[adf]\\.set\\([^,]+\\s*,\\s*encodeURIComponent\\s*\\(\\s*([a-zA-Z0-9$]+)\\(",
		@"\\b[a-zA-Z0-9]+\\s*&&\\s*[a-zA-Z0-9]+\\.set\\([^,]+\\s*,\\s*encodeURIComponent\\s*\\(\\s*([a-zA-Z0-9$]+)\\(",
		@"(?:\\b|[^a-zA-Z0-9$])([a-zA-Z0-9$]{2})\\s*=\\s*function\\(\\s*a\\s*\\)\\s*\\{\\s*a\\s*=\\s*a\\.split\\(\\s*\"\"\\s*\\)",
		@"([a-zA-Z0-9$]+)\\s*=\\s*function\\(\\s*a\\s*\\)\\s*\\{\\s*a\\s*=\\s*a\\.split\\(\\s*\"\"\\s*\\)",
		/*The rest patterns are supposed to be obsolete but I am keep them here in case some older pattern matches the YouTube API in the future
		 *IMPORTANT: Please note that the patterns above should be placed in the same order as seen in youtube-dl here: https://github.com/ytdl-org/youtube-dl/blob/master/youtube_dl/extractor/youtube.py#L1344
		 *If they do not match the same order some video won't play because of using the wrong signature.
		 */
		@"([\"\\\'])signature\\1\\s*,\\s*([a-zA-Z0-9$]+)\\(",
		@"\\.sig\\|\\|([a-zA-Z0-9$]+)\\(",
		@"yt\\.akamaized\\.net/\\)\\s*\\|\\|\\s*.*?\\s*[cs]\\s*&&\\s*[adf]\\.set\\([^,]+\\s*,\\s*(?:encodeURIComponent\\s*\\()?\\s*([a-zA-Z0-9$]+)\\(",
		@"\\b[cs]\\s*&&\\s*[adf]\\.set\\([^,]+\\s*,\\s*([a-zA-Z0-9$]+)\\(",
		@"\\b[a-zA-Z0-9]+\\s*&&\\s*[a-zA-Z0-9]+\\.set\\([^,]+\\s*,\\s*([a-zA-Z0-9$]+)\\(",
		@"\\bc\\s*&&\\s*a\\.set\\([^,]+\\s*,\\s*\\([^)]*\\)\\s*\\(\\s*([a-zA-Z0-9$]+)\\(",
		@"\\bc\\s*&&\\s*[a-zA-Z0-9]+\\.set\\([^,]+\\s*,\\s*\\([^)]*\\)\\s*\\(\\s*([a-zA-Z0-9$]+)\\(",
		@"\\bc\\s*&&\\s*[a-zA-Z0-9]+\\.set\\([^,]+\\s*,\\s*\\([^)]*\\)\\s*\\(\\s*([a-zA-Z0-9$]+)\\("
	];
	
	NSArray *hardCodedPatternsExpressions = [self regularExpressionFromPatterns:hardCodedPatterns];
	NSArray *customPatternsExpressions = [self regularExpressionFromPatterns:customPatterns];

	NSMutableArray<NSRegularExpression *>*validRegularExpressions = [NSMutableArray new];
  
	for (NSRegularExpression *regularExpression in customPatternsExpressions.count == 0 ? hardCodedPatternsExpressions : customPatternsExpressions) {
		if (_signatureFunction)
			break;
		
		NSArray<NSTextCheckingResult *> *regexResults =  [regularExpression matchesInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length)];
		
		for (NSTextCheckingResult *signatureResult in regexResults)
		{
			NSString *signatureFunctionName = signatureResult.numberOfRanges > 1 ? [script substringWithRange:[signatureResult rangeAtIndex:1]] : nil;
			if (!signatureFunctionName)
				continue;
			
			JSValue *signatureFunction = self.context[signatureFunctionName];
			if (signatureFunction.isObject)
			{
				_signatureFunction = signatureFunction;
				break;
			}
		}
	}
	
	if (!_signatureFunction)
		XCDYouTubeLogWarning(@"No signature function in player script: \n%@. Regular Expressions: \n%@", script, validRegularExpressions);
	
	return self;
}

- (NSString *) unscrambleSignature:(NSString *)scrambledSignature
{
	if (!self.signatureFunction || !scrambledSignature)
		return nil;
	
	JSValue *unscrambledSignature = [self.signatureFunction callWithArguments:@[ scrambledSignature ]];
	return [unscrambledSignature isString] ? [unscrambledSignature toString] : nil;
}

- (NSArray<NSRegularExpression *> *)regularExpressionFromPatterns:(NSArray<NSString *> *)patterns
{
	NSMutableArray<NSRegularExpression *>*validRegularExpressions = [NSMutableArray new];
	
	for (NSString *pattern in patterns)
	{
		NSError* error = NULL;
		NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
		
		if (error)
		{
			XCDYouTubeLogWarning(@"Error when creating regular expression from the pattern: %@", pattern);
			continue;
		}
    
		if (regex != nil)
		{
			[validRegularExpressions addObject:regex];
		}
	}
	
	return validRegularExpressions.copy;
}

@end

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

- (instancetype) initWithString:(NSString *)string
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
	
   //See list of regex patterns here https://github.com/rg3/youtube-dl/blob/master/youtube_dl/extractor/youtube.py#L1179
    NSArray<NSString *>*patterns = @[@"\\.sig\\|\\|([a-zA-Z0-9$]+)\\(",
                                     @"[\"']signature[\"']\\s*,\\s*([^\\(]+)",
                                     @"yt\\.akamaized\\.net/\\)\\s*\\|\\|\\s*.*?\\s*c\\s*&&\\s*d|a\\.set\\([^,]+\\s*,\\s*(?:encodeURIComponent\\s*\\()?([a-zA-Z0-9$]+)\\(",
                                     @"\\bc\\s*&&\\s*d|a\\.set\\([^,]+\\s*,\\s*(?:encodeURIComponent\\s*\\()?\\s*([a-zA-Z0-9$]+)\\(",
                                     @"\\bc\\s*&&\\s*d|a\\.set\\([^,]+\\s*,\\s*\\([^)]*\\)\\s*\\(\\s*([a-zA-Z0-9$]+)\\("
                                     ];
	
    NSMutableArray<NSRegularExpression *>*validRegularExpressions = [NSMutableArray new];

    for (NSString *pattern in patterns) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
        if (regex != nil)
        {
            [validRegularExpressions addObject:regex];
        }
    }
	
    for (NSRegularExpression *regularExpression in validRegularExpressions) {
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
		XCDYouTubeLogWarning(@"No signature function in player script");
	
	return self;
}

- (NSString *) unscrambleSignature:(NSString *)scrambledSignature
{
	if (!self.signatureFunction || !scrambledSignature)
		return nil;
	
	JSValue *unscrambledSignature = [self.signatureFunction callWithArguments:@[ scrambledSignature ]];
	return [unscrambledSignature isString] ? [unscrambledSignature toString] : nil;
}

@end

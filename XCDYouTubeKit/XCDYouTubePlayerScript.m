//
//  Copyright (c) 2013-2015 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubePlayerScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "XCDYouTubeLogger.h"

@interface XCDYouTubePlayerScript ()
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) JSValue *signatureFunction;
@end

@implementation XCDYouTubePlayerScript

- (instancetype) initWithString:(NSString *)string
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	NSString *script = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	XCDYouTubeLogTrace(@"%@", script);
	NSRegularExpression *anonymousFunctionRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\(function\\([^)]*\\)\\{(.*)\\}\\)\\([^)]*\\)" options:NSRegularExpressionDotMatchesLineSeparators error:NULL];
	NSTextCheckingResult *anonymousFunctionResult = [anonymousFunctionRegularExpression firstMatchInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length)];
	if (anonymousFunctionResult.numberOfRanges > 1)
		script = [script substringWithRange:[anonymousFunctionResult rangeAtIndex:1]];
	else
		XCDYouTubeLogWarning(@"Unexpected player script (no anonymous function found)");
	
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
		@"navigator": @{},
	};
	_context[@"window"] = @{};
	for (NSString *propertyName in environment)
	{
		JSValue *value = [JSValue valueWithObject:environment[propertyName] inContext:_context];
		_context[propertyName] = value;
		_context[@"window"][propertyName] = value;
	}
	
	[_context evaluateScript:script];
	
	NSRegularExpression *signatureRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[\"']signature[\"']\\s*,\\s*([^\\(]+)" options:NSRegularExpressionCaseInsensitive error:NULL];
	NSTextCheckingResult *signatureResult = [signatureRegularExpression firstMatchInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length)];
	NSString *signatureFunctionName = signatureResult.numberOfRanges > 1 ? [script substringWithRange:[signatureResult rangeAtIndex:1]] : nil;
	
	if (signatureFunctionName)
		_signatureFunction = self.context[signatureFunctionName];
	
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

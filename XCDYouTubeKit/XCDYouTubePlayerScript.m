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
		return nil;
	
	NSString *script = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	XCDYouTubeLogTrace(@"%@", script);
	static NSString *jsPrologue = @"(function()";
	static NSString *jsEpilogue = @")();";
	if ([script hasPrefix:jsPrologue] && [script hasSuffix:jsEpilogue])
		script = [script substringWithRange:NSMakeRange(jsPrologue.length, script.length - (jsPrologue.length + jsEpilogue.length))];
	else
		XCDYouTubeLogWarning(@"Unexpected player script (not an anonymous function)");
	
	_context = [JSContext new];
	_context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
		XCDYouTubeLogWarning(@"JavaScript exception: %@", exception);
	};
	
	for (NSString *propertyPath in @[ @"window.navigator", @"document", @"navigator" ])
	{
		JSValue *object = (JSValue *)_context;
		for (NSString *propertyName in [propertyPath componentsSeparatedByString:@"."])
		{
			object[propertyName] = [JSValue valueWithNewObjectInContext:_context];
			object = object[propertyName];
		}
	}
	
	[_context evaluateScript:script];
	
	NSRegularExpression *signatureRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[\"']signature[\"']\\s*,\\s*([^\\(]+)" options:NSRegularExpressionCaseInsensitive error:NULL];
	NSTextCheckingResult *result = [signatureRegularExpression firstMatchInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length)];
	NSString *signatureFunctionName = result.numberOfRanges > 1 ? [script substringWithRange:[result rangeAtIndex:1]] : nil;
	
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

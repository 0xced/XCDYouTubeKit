//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubePlayerScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

@interface XCDYouTubePlayerScript ()
@property (nonatomic, assign) JSGlobalContextRef context;
@property (nonatomic, assign) JSObjectRef signatureFunction;
@end

@implementation XCDYouTubePlayerScript

- (instancetype) initWithString:(NSString *)string
{
	if (!(self = [super init]))
		return nil;
	
	NSString *script = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	static NSString *jsPrologue = @"(function()";
	static NSString *jsEpilogue = @")();";
	if ([script hasPrefix:jsPrologue] && [script hasSuffix:jsEpilogue])
		script = [script substringWithRange:NSMakeRange(jsPrologue.length, script.length - (jsPrologue.length + jsEpilogue.length))];
	
	__block NSString *signatureFunctionName = nil;
	NSRegularExpression *signatureRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"signature\\s*=\\s*([a-zA-Z]+)" options:NSRegularExpressionCaseInsensitive error:NULL];
	[signatureRegularExpression enumerateMatchesInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		signatureFunctionName = [script substringWithRange:[result rangeAtIndex:1]];
		*stop = YES;
	}];
	
	if (!signatureFunctionName)
		return nil;
	
	_context = JSGlobalContextCreate(NULL);
	
	JSStringRef scriptRef = JSStringCreateWithCFString((__bridge CFStringRef)script);
	JSEvaluateScript(_context, scriptRef, NULL, NULL, 0, NULL);
	JSStringRelease(scriptRef);
	
	JSStringRef signatureFunctionNameRef = JSStringCreateWithCFString((__bridge CFStringRef)signatureFunctionName);
	JSValueRef signatureFunction = JSEvaluateScript(_context, signatureFunctionNameRef, NULL, NULL, 0, NULL);
	JSStringRelease(signatureFunctionNameRef);
	if (JSValueIsObject(_context, signatureFunction))
		_signatureFunction = (JSObjectRef)signatureFunction;
	
	if (!JSObjectIsFunction(_context, _signatureFunction))
		return nil;
	
	return self;
}

- (void) dealloc
{
	JSGlobalContextRelease(_context);
}

- (NSString *) unscrambleSignature:(NSString *)scrambledSignature
{
	if (!scrambledSignature)
		return nil;
	
	JSStringRef scrambledSignatureRef = JSStringCreateWithCFString((__bridge CFStringRef)scrambledSignature);
	JSValueRef scrambledSignatureValue = JSValueMakeString(self.context, scrambledSignatureRef);
	JSStringRelease(scrambledSignatureRef);
	
	JSValueRef unscrambledSignatureValue = JSObjectCallAsFunction(self.context, self.signatureFunction, NULL, 1, &scrambledSignatureValue, NULL);
	if (JSValueIsString(self.context, unscrambledSignatureValue))
	{
		JSStringRef unscrambledSignatureRef = JSValueToStringCopy(self.context, unscrambledSignatureValue, NULL);
		CFStringRef unscrambledSignature = unscrambledSignatureRef ? JSStringCopyCFString(kCFAllocatorDefault, unscrambledSignatureRef) : NULL;
		return CFBridgingRelease(unscrambledSignature);
	}
	
	return nil;
}

@end

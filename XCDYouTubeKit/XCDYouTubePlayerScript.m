//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubePlayerScript.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import <Availability.h>
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#warning Rewrite JavaScriptCore code with JSContext + JSValue (available since iOS 7) instead the verbose C API.
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_9
#warning Rewrite JavaScriptCore code with JSContext + JSValue (available since OS X 10.9) instead the verbose C API.
#endif

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
	NSRegularExpression *signatureRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"signature\\s*=\\s*([^\\(]+)" options:NSRegularExpressionCaseInsensitive error:NULL];
	[signatureRegularExpression enumerateMatchesInString:script options:(NSMatchingOptions)0 range:NSMakeRange(0, script.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		signatureFunctionName = [script substringWithRange:[result rangeAtIndex:1]];
		*stop = YES;
	}];
	
	if (!signatureFunctionName)
		return nil;
	
	_context = JSGlobalContextCreate(NULL);
	
	for (NSString *propertyName in @[ @"window", @"document" ])
	{
		JSStringRef propertyNameRef = JSStringCreateWithCFString((__bridge CFStringRef)propertyName);
		JSValueRef dummyValueRef = JSValueMakeString(_context, propertyNameRef); // can be anything but undefined or null
		JSObjectSetProperty(_context, JSContextGetGlobalObject(_context), propertyNameRef, dummyValueRef, 0, NULL);
		JSStringRelease(propertyNameRef);
	}
	
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
	if (_context)
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
		JSStringRelease(unscrambledSignatureRef);
		return CFBridgingRelease(unscrambledSignature);
	}
	
	return nil;
}

@end

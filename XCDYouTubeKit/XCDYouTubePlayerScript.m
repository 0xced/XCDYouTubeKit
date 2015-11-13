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

- (instancetype)initWithString:(NSString *)string {
    if (!(self = [super init]))
        return nil;
    
    NSString *signatureFunctionName = [self searchRegexInString:string
                                                    WithPattern:@".sig\\|\\|([a-zA-Z0-9]+)\\("
                                                          range:1
                                                 lineSeparators:YES];
    
    if (!signatureFunctionName) {
        XCDYouTubeLogWarning(@"Unexpected player script (not an anonymous function)");
    }
    
    _context = [JSContext new];
    _context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        XCDYouTubeLogWarning(@"JavaScript exception: %@", exception);
    };
    
    string = [self searchRegexInString:string WithPattern:@"\\{var\\s.*;\\}" range:0 lineSeparators:YES];
    
    NSDictionary *environment = @{
                                  @"navigator":@{@"presentation":@" "},
                                  @"document":@{@"currentScript":@{@"src": @" "}},
                                  @"location":@{@"protocol":@" ", @"hash":@" "},
                                  };
    for (NSString *propertyName in environment) {
        JSValue *value = [JSValue valueWithObject:environment[propertyName] inContext:_context];
        _context[propertyName] = value;
    }
    
    [_context evaluateScript:string];
    
    _signatureFunction = self.context[signatureFunctionName];
    
    return self;
}

- (NSString *) unscrambleSignature:(NSString *)scrambledSignature {
	if (!self.signatureFunction || !scrambledSignature)
		return nil;
	
	JSValue *unscrambledSignature = [self.signatureFunction callWithArguments:@[ scrambledSignature ]];
	return [unscrambledSignature isString] ? [unscrambledSignature toString] : nil;
}

- (NSString *)searchRegexInString:(NSString *)input
                      WithPattern:(NSString *)pattern
                            range:(NSInteger)range
                   lineSeparators:(BOOL)lineSeparators {
    
    if (!input || input.length == 0) { return nil;}
    if (!pattern || pattern.length == 0) { return nil;}
    
    NSString *output = nil;
    NSArray *matches = nil;
    NSError *error = nil;
    
    NSRegularExpressionOptions _options = NSRegularExpressionCaseInsensitive;
    if (lineSeparators) {
        _options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
    }
    
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                    options:_options
                                                                      error:&error];
    
    
    if (!error) {
        
        matches = [reg matchesInString:input options:0 range:NSMakeRange(0, [input length])];
        
        if (matches.count > 0) {
            //NSLog(@"count: %d", matches.count);
            NSTextCheckingResult *result = [matches objectAtIndex:0];
            
            if ([result numberOfRanges] >= range+1) {
                NSRange r = [result rangeAtIndex:range];
                if ([input substringWithRange:r]) {
                    output = [input substringWithRange:r];
                    return output;
                }
            }
        }
    }
    
    return output;
}

@end

//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeKitTestCase.h"

@interface XCTest (Private)
- (void) setUpTestWithSelector:(SEL)selector;
@end

@interface XCDYouTubeKitTestCase ()
@property NSURL *cassetteURL;
@end

static NSString *const offlineSuffix = @"_offline";

@implementation XCDYouTubeKitTestCase

// When running tests with the `ONLINE_TESTS` environment variable, tests whose
// selector ends with `_offline` are not executed.
// Also, VCR is not used at all, neither for recording nor for replaying.
+ (NSArray *) testInvocations
{
	BOOL onlineTests = [[[[NSProcessInfo processInfo] environment] objectForKey:@"ONLINE_TESTS"] boolValue];
	if (!onlineTests)
		return [super testInvocations];
	
	NSMutableArray *testInvocations = [NSMutableArray new];
	for (NSInvocation *invocation in [super testInvocations])
	{
		if (![NSStringFromSelector(invocation.selector) hasSuffix:offlineSuffix])
			[testInvocations addObject:invocation];
	}
	return [testInvocations copy];
}

- (void) setUpTestWithSelector:(SEL)selector
{
	[super setUpTestWithSelector:selector];
	
	BOOL onlineTests = [[[[NSProcessInfo processInfo] environment] objectForKey:@"ONLINE_TESTS"] boolValue];
	if (onlineTests)
		return;
	
	NSString *cassettesDirectory = [[[NSProcessInfo processInfo] environment] objectForKey:@"VCR_CASSETTES_DIRECTORY"];
	cassettesDirectory = [cassettesDirectory stringByAppendingPathComponent:NSStringFromClass(self.class)];
	if ([[NSFileManager defaultManager] fileExistsAtPath:cassettesDirectory])
	{
		self.cassetteURL = [NSURL fileURLWithPath:[[cassettesDirectory stringByAppendingPathComponent:NSStringFromSelector(selector)] stringByAppendingPathExtension:@"json"]];
		[[NSFileManager defaultManager] removeItemAtURL:self.cassetteURL error:NULL];
		[VCR setRecording:YES];
	}
	else
	{
		NSString *testName = NSStringFromSelector(selector);
		if ([testName hasSuffix:offlineSuffix])
			testName = [testName substringToIndex:testName.length - offlineSuffix.length];
		
		self.cassetteURL = [[NSBundle bundleForClass:self.class] URLForResource:testName withExtension:@"json" subdirectory:[@"Cassettes" stringByAppendingPathComponent:NSStringFromClass(self.class)]];
		XCTAssertNotNil(self.cassetteURL);
		[VCR loadCassetteWithContentsOfURL:self.cassetteURL];
		[VCR setReplaying:YES];
	}
}

- (void) tearDown
{
	if ([VCR isRecording])
	{
		[VCR save:self.cassetteURL.path];
		if (![[NSFileManager defaultManager] fileExistsAtPath:self.cassetteURL.path])
			[@"[]" writeToURL:self.cassetteURL atomically:YES encoding:NSASCIIStringEncoding error:NULL];
	}
	
	[VCR stop];
	[[VCRCassetteManager defaultManager] setCurrentCassette:nil];
	
	[super tearDown];
}

@end

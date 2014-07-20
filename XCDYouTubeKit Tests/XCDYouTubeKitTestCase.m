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

@implementation XCDYouTubeKitTestCase

- (void) setUpTestWithSelector:(SEL)selector
{
	[super setUpTestWithSelector:selector];
	
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
		self.cassetteURL = [[NSBundle bundleForClass:self.class] URLForResource:NSStringFromSelector(selector) withExtension:@"json" subdirectory:[@"Cassettes" stringByAppendingPathComponent:NSStringFromClass(self.class)]];
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

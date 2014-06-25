//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"

@interface XCDYouTubeVideoTestCase : XCTestCase
@end

@implementation XCDYouTubeVideoTestCase

- (void) testNilInfo
{
	NSError *error;
	NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/get_video_info"];
	NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"application/x-www-form-urlencoded" expectedContentLength:NSURLResponseUnknownLength textEncodingName:nil];
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:nil info:nil playerScript:nil response:response error:&error];
	XCTAssertNil(video);
	XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
	XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
	XCTAssertEqualObjects(url, error.userInfo[NSURLErrorKey]);
}

- (void) testEmptyInfo
{
	NSError *error;
	NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/get_video_info"];
	NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"application/x-www-form-urlencoded" expectedContentLength:NSURLResponseUnknownLength textEncodingName:nil];
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:nil info:@{} playerScript:nil response:response error:&error];
	XCTAssertNil(video);
	XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
	XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
	XCTAssertEqualObjects(url, error.userInfo[NSURLErrorKey]);
}

- (void) testInvalidInfo
{
	NSError *error;
	NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/get_video_info"];
	NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"application/x-www-form-urlencoded" expectedContentLength:NSURLResponseUnknownLength textEncodingName:nil];
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:nil info:@{ @"url_encoded_fmt_stream_map": @"" } playerScript:nil response:response error:&error];
	XCTAssertNil(video);
	XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
	XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
	XCTAssertEqualObjects(url, error.userInfo[NSURLErrorKey]);
}

- (void) testVideoEquality
{
	XCDYouTubeVideo *videoA = [[XCDYouTubeVideo alloc] initWithIdentifier:@"videoA" info:@{ @"url_encoded_fmt_stream_map": @"url=http://www.youtube.com/videoA.mp4&itag=123"} playerScript:nil response:nil error:NULL];
	XCDYouTubeVideo *videoB = [[XCDYouTubeVideo alloc] initWithIdentifier:@"videoB" info:@{ @"url_encoded_fmt_stream_map": @"url=http://www.youtube.com/videoB.mp4&itag=123"} playerScript:nil response:nil error:NULL];
	
	XCTAssertEqualObjects(videoA.identifier, @"videoA");
	XCTAssertEqualObjects(videoB.identifier, @"videoB");
	XCTAssertNotEqualObjects(videoA, videoB);
	XCTAssertNotEqualObjects(videoA, [NSDate date]);
}

@end

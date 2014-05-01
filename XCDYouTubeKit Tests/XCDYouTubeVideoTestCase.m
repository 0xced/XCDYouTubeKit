//
//  Copyright (c) 2013-2014 Cédric Luthi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XCDYouTubeVideo+Private.h"
#import "XCDYouTubeError.h"

@interface XCDYouTubeVideoTestCase : XCTestCase
@end

@implementation XCDYouTubeVideoTestCase

- (void) testNilData
{
	NSError *error;
	NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/get_video_info"];
	NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"application/x-www-form-urlencoded" expectedContentLength:NSURLResponseUnknownLength textEncodingName:nil];
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:nil response:response data:nil error:&error];
	XCTAssertNil(video);
	XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
	XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
	XCTAssertEqualObjects(url, error.userInfo[NSURLErrorKey]);
}

- (void) testEmptyData
{
	NSError *error;
	NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/get_video_info"];
	NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"application/x-www-form-urlencoded" expectedContentLength:NSURLResponseUnknownLength textEncodingName:nil];
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:nil response:response data:[NSData data] error:&error];
	XCTAssertNil(video);
	XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
	XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
	XCTAssertEqualObjects(url, error.userInfo[NSURLErrorKey]);
}

- (void) testInvalidData
{
	NSError *error;
	NSData *data = [@"status=ok" dataUsingEncoding:NSASCIIStringEncoding];
	NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/get_video_info"];
	NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"application/x-www-form-urlencoded" expectedContentLength:NSURLResponseUnknownLength textEncodingName:nil];
	XCDYouTubeVideo *video = [[XCDYouTubeVideo alloc] initWithIdentifier:nil response:response data:data error:&error];
	XCTAssertNil(video);
	XCTAssertEqualObjects(error.domain, XCDYouTubeVideoErrorDomain);
	XCTAssertEqual(error.code, XCDYouTubeErrorNoStreamAvailable);
	XCTAssertEqualObjects(url, error.userInfo[NSURLErrorKey]);
}

@end

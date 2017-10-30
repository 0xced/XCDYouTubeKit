//
//  XCDYouTubeDashManifestXML.m
//  XCDYouTubeKit
//
//  Created by Soneé John on 10/24/17.
//  Copyright © 2017 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeDashManifestXML.h"

@interface XCDYouTubeDashManifestXML()
@property (nonatomic, readonly) NSString *XMLString;
@end


@implementation XCDYouTubeDashManifestXML

- (instancetype)initWithXMLString:(NSString *)XMLString
{
	if (!(self = [super init]))
		return nil; // LCOV_EXCL_LINE
	
	_XMLString = XMLString;
	
	return self;
}

- (NSDictionary *)streamURLs
{
	
	//Catch the type
	NSError *xmlTypeRegexError = NULL;
	NSRegularExpression *xmlTypeRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=(type=\"))(\\w|\\d|\\n|[().,\\-:;@#$%^&*\\[\\]\"'+–/\\/®°⁰!?{}|`~]| )+?(?=(\"))" options:NSRegularExpressionAnchorsMatchLines error:&xmlTypeRegexError];
	if (xmlTypeRegexError)
		return nil;
	NSTextCheckingResult *xmlTypeRegexCheckingResult = [xmlTypeRegex firstMatchInString:self.XMLString options:0 range:NSMakeRange(0, self.XMLString.length)];
	
	NSString *xmlType = [self.XMLString substringWithRange:xmlTypeRegexCheckingResult.range];
	if (![xmlType containsString:@"static"])
		return nil;
	
	//Catch all URLs
	NSError *error = nil;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=(<BaseURL>))(\\w|\\d|\\n|[().,\\-:;@#$%^&*\\[\\]\"'+–/\\/®°⁰!?{}|`~]| )+?(?=(</BaseURL>))" options:0 error:&error];
	
	if (error)
		return nil;
	
    NSArray *checkingResults = [regex matchesInString:self.XMLString options:0 range:NSMakeRange(0, [self.XMLString length])];
	
	if (checkingResults.count == 0 || checkingResults == nil)
		return nil;
	
	NSMutableArray <NSURL *>*URLs = [NSMutableArray new];
	NSMutableDictionary *streamURLs = [NSMutableDictionary new];

	for (NSTextCheckingResult *checkingResult in checkingResults)
	{
		NSString* substringForMatch = [self.XMLString substringWithRange:checkingResult.range];
		NSURL *url = [NSURL URLWithString:substringForMatch];
	
		if ([url.absoluteString containsString:@"youtube"] && [url.absoluteString containsString:@"itag"])
		{
			[URLs addObject:url];
		}
	}
	
	for (NSURL *url in URLs)
	{
		NSError *itagRegexError = nil;
		NSRegularExpression *itagRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=(/itag/))(\\w|\\d|\\n|[().,\\-:;@#$%^&*\\[\\]\"'+–/\\/®°⁰!?{}|`~]| )+?(?=(/))" options:NSRegularExpressionAnchorsMatchLines error:&itagRegexError];
		
		if (itagRegexError)
			continue;
		
		NSTextCheckingResult *itagCheckingResult = [itagRegex firstMatchInString:(NSString *_Nonnull)url.absoluteString options:0 range:NSMakeRange(0, url.absoluteString.length)];

		NSString *itag = [url.absoluteString substringWithRange:itagCheckingResult.range];
		streamURLs[@(itag.integerValue)] = url;
	}
	
	if (streamURLs.count == 0)
		return nil;
	
	return streamURLs;
}

@end

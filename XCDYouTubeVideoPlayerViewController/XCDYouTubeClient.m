//
//  XCDYouTubeClient.m
//  XCDYouTubeVideoPlayerViewController
//
//  Created by Cédric Luthi on 17.03.14.
//  Copyright (c) 2014 Cédric Luthi. All rights reserved.
//

#import "XCDYouTubeClient.h"

@implementation XCDYouTubeClient

@synthesize languageIdentifier = _languageIdentifier;

- (instancetype) init
{
	return [self initWithLanguageIdentifier:nil];
}

- (instancetype) initWithLanguageIdentifier:(NSString *)languageIdentifier
{
	if (!(self = [super init]))
		return nil;
	
	_languageIdentifier = languageIdentifier;
	
	return self;
}

- (NSString *) languageIdentifier
{
	if (!_languageIdentifier)
	{
		_languageIdentifier = @"en";
		NSArray *preferredLocalizations = [[NSBundle mainBundle] preferredLocalizations];
		if (preferredLocalizations.count > 0)
			_languageIdentifier = [NSLocale canonicalLanguageIdentifierFromString:preferredLocalizations[0]] ?: _languageIdentifier;
	}
	return _languageIdentifier;
}

- (id<XCDYouTubeOperation>) getVideoWithIdentifier:(NSString *)videoIdentifier completionHandler:(void (^)(XCDYouTubeVideo *video, NSError *error))completionHandler
{
	return nil;
}

@end

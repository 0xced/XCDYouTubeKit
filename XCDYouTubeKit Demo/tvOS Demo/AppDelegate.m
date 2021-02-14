//
//  Copyright © 2013-2016 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import <GoogleAPIClientForREST/GTLRYouTube.h>

#import "PlaylistCollectionViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) GTLRYouTubeService *youTubeService;

@end

@implementation AppDelegate

@synthesize window = _window;

- (GTLRYouTubeService *) youTubeService
{
	GTLRYouTubeService *_youTubeService = [[GTLRYouTubeService alloc] init];
	_youTubeService.shouldFetchNextPages = YES;
	_youTubeService.retryEnabled = YES;
	// Please enter your YouTube API Key in `XCDYouTubeKit Demo/tvOS Demo/Supporting Files/YouTube-API-Key.plist`
	NSData *youTubeAPIKeyData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"YouTube-API-Key" withExtension:@"plist"]];
	_youTubeService.APIKey = [NSPropertyListSerialization propertyListWithData:youTubeAPIKeyData options:NSPropertyListImmutable format:NULL error:NULL];
	NSAssert(_youTubeService.APIKey.length > 0, @"An API key is required, see https://developers.google.com/youtube/v3/getting-started");

	return _youTubeService;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	PlaylistCollectionViewController *playlistCollectionViewController = (PlaylistCollectionViewController *)navigationController.viewControllers[0];

	GTLRYouTubeQuery_PlaylistItemsList *playlistItemsQuery = [GTLRYouTubeQuery_PlaylistItemsList queryWithPart:@[@"snippet"]];
	playlistItemsQuery.playlistId = @"PLivjPDlt6ApTA612eSR6Y7vrNys2hBKIr";
	playlistItemsQuery.maxResults = 50;

	[self.youTubeService executeQuery:playlistItemsQuery
						 completionHandler:^(GTLRServiceTicket *callbackTicket,
						 GTLRYouTube_PlaylistItemListResponse *playlistItemList,
						 NSError *callbackError) {
		if (callbackError != nil) {
			NSLog(@"Fetch failed: %@", callbackError);
		} else {
			playlistCollectionViewController.title = playlistItemList.items[0].snippet.title;
			playlistCollectionViewController.items = playlistItemList.items;
		}
	}];
	
	return YES;
}

@end

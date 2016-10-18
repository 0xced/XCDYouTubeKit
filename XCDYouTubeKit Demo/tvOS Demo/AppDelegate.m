//
//  Copyright © 2013-2016 Cédric Luthi. All rights reserved.
//

#import "AppDelegate.h"

#import <GoogleAPIClient/GTLYouTube.h>

#import "PlaylistCollectionViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) GTLServiceYouTube *youTubeService;

@end

@implementation AppDelegate

@synthesize window = _window;

- (GTLServiceYouTube *) youTubeService
{
	if (!_youTubeService)
	{
		_youTubeService = [GTLServiceYouTube new];
		_youTubeService.shouldFetchNextPages = YES;
		_youTubeService.retryEnabled = YES;
		// Please enter your YouTube API Key in `XCDYouTubeKit Demo/tvOS Demo/Supporting Files/YouTube-API-Key.plist`
		NSData *youTubeAPIKeyData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"YouTube-API-Key" withExtension:@"plist"]];
		_youTubeService.APIKey = [NSPropertyListSerialization propertyListWithData:youTubeAPIKeyData options:NSPropertyListImmutable format:NULL error:NULL];
		NSAssert(_youTubeService.APIKey.length > 0, @"An API key is required, see https://developers.google.com/youtube/v3/getting-started");
	}
	return _youTubeService;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	PlaylistCollectionViewController *playlistCollectionViewController = (PlaylistCollectionViewController *)navigationController.viewControllers[0];
	
	GTLQueryYouTube *playlistQuery = [GTLQueryYouTube queryForPlaylistsListWithPart:@"snippet"];
	playlistQuery.identifier = @"PLivjPDlt6ApTA612eSR6Y7vrNys2hBKIr";
	
	GTLQueryYouTube *playlistItemsQuery = [GTLQueryYouTube queryForPlaylistItemsListWithPart:@"snippet"];
	playlistItemsQuery.playlistId = playlistQuery.identifier;
	playlistItemsQuery.maxResults = 50;
	
	[self.youTubeService executeQuery:playlistQuery completionHandler:^(GTLServiceTicket *ticket, GTLYouTubePlaylistListResponse *response, NSError *error) {
		if (response)
			playlistCollectionViewController.title = ((GTLYouTubePlaylist *)response.items.firstObject).snippet.title;
		else
			NSLog(@"Playlist Query Error: %@", error);
	}];
	
	[self.youTubeService executeQuery:playlistItemsQuery completionHandler:^(GTLServiceTicket *ticket, GTLYouTubePlaylistItemListResponse *response, NSError *error) {
		if (response)
			playlistCollectionViewController.items = response.items;
		else
			NSLog(@"PlaylistItems Query Error: %@", error);
	}];
	
	return YES;
}

@end

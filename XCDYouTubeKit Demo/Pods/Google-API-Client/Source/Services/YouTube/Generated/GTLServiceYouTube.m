/* Copyright (c) 2014 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLServiceYouTube.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Programmatic access to YouTube features.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLServiceYouTube (0 custom class methods, 0 custom properties)

#import "GTLYouTube.h"

@implementation GTLServiceYouTube

#if DEBUG
// Method compiled in debug builds just to check that all the needed support
// classes are present at link time.
+ (NSArray *)checkClasses {
  NSArray *classes = [NSArray arrayWithObjects:
                      [GTLQueryYouTube class],
                      [GTLYouTubeAccessPolicy class],
                      [GTLYouTubeActivity class],
                      [GTLYouTubeActivityContentDetails class],
                      [GTLYouTubeActivityContentDetailsBulletin class],
                      [GTLYouTubeActivityContentDetailsChannelItem class],
                      [GTLYouTubeActivityContentDetailsComment class],
                      [GTLYouTubeActivityContentDetailsFavorite class],
                      [GTLYouTubeActivityContentDetailsLike class],
                      [GTLYouTubeActivityContentDetailsPlaylistItem class],
                      [GTLYouTubeActivityContentDetailsPromotedItem class],
                      [GTLYouTubeActivityContentDetailsRecommendation class],
                      [GTLYouTubeActivityContentDetailsSocial class],
                      [GTLYouTubeActivityContentDetailsSubscription class],
                      [GTLYouTubeActivityContentDetailsUpload class],
                      [GTLYouTubeActivityListResponse class],
                      [GTLYouTubeActivitySnippet class],
                      [GTLYouTubeCdnSettings class],
                      [GTLYouTubeChannel class],
                      [GTLYouTubeChannelAuditDetails class],
                      [GTLYouTubeChannelBannerResource class],
                      [GTLYouTubeChannelBrandingSettings class],
                      [GTLYouTubeChannelContentDetails class],
                      [GTLYouTubeChannelContentOwnerDetails class],
                      [GTLYouTubeChannelConversionPing class],
                      [GTLYouTubeChannelConversionPings class],
                      [GTLYouTubeChannelListResponse class],
                      [GTLYouTubeChannelLocalization class],
                      [GTLYouTubeChannelSection class],
                      [GTLYouTubeChannelSectionContentDetails class],
                      [GTLYouTubeChannelSectionListResponse class],
                      [GTLYouTubeChannelSectionSnippet class],
                      [GTLYouTubeChannelSettings class],
                      [GTLYouTubeChannelSnippet class],
                      [GTLYouTubeChannelStatistics class],
                      [GTLYouTubeChannelStatus class],
                      [GTLYouTubeChannelTopicDetails class],
                      [GTLYouTubeContentRating class],
                      [GTLYouTubeGeoPoint class],
                      [GTLYouTubeGuideCategory class],
                      [GTLYouTubeGuideCategoryListResponse class],
                      [GTLYouTubeGuideCategorySnippet class],
                      [GTLYouTubeI18nLanguage class],
                      [GTLYouTubeI18nLanguageListResponse class],
                      [GTLYouTubeI18nLanguageSnippet class],
                      [GTLYouTubeI18nRegion class],
                      [GTLYouTubeI18nRegionListResponse class],
                      [GTLYouTubeI18nRegionSnippet class],
                      [GTLYouTubeImageSettings class],
                      [GTLYouTubeIngestionInfo class],
                      [GTLYouTubeInvideoBranding class],
                      [GTLYouTubeInvideoPosition class],
                      [GTLYouTubeInvideoPromotion class],
                      [GTLYouTubeInvideoTiming class],
                      [GTLYouTubeLanguageTag class],
                      [GTLYouTubeLiveBroadcast class],
                      [GTLYouTubeLiveBroadcastContentDetails class],
                      [GTLYouTubeLiveBroadcastListResponse class],
                      [GTLYouTubeLiveBroadcastSnippet class],
                      [GTLYouTubeLiveBroadcastStatus class],
                      [GTLYouTubeLiveStream class],
                      [GTLYouTubeLiveStreamContentDetails class],
                      [GTLYouTubeLiveStreamListResponse class],
                      [GTLYouTubeLiveStreamSnippet class],
                      [GTLYouTubeLiveStreamStatus class],
                      [GTLYouTubeLocalizedProperty class],
                      [GTLYouTubeLocalizedString class],
                      [GTLYouTubeMonitorStreamInfo class],
                      [GTLYouTubePageInfo class],
                      [GTLYouTubePlaylist class],
                      [GTLYouTubePlaylistContentDetails class],
                      [GTLYouTubePlaylistItem class],
                      [GTLYouTubePlaylistItemContentDetails class],
                      [GTLYouTubePlaylistItemListResponse class],
                      [GTLYouTubePlaylistItemSnippet class],
                      [GTLYouTubePlaylistItemStatus class],
                      [GTLYouTubePlaylistListResponse class],
                      [GTLYouTubePlaylistPlayer class],
                      [GTLYouTubePlaylistSnippet class],
                      [GTLYouTubePlaylistStatus class],
                      [GTLYouTubePromotedItem class],
                      [GTLYouTubePromotedItemId class],
                      [GTLYouTubePropertyValue class],
                      [GTLYouTubeResourceId class],
                      [GTLYouTubeSearchListResponse class],
                      [GTLYouTubeSearchResult class],
                      [GTLYouTubeSearchResultSnippet class],
                      [GTLYouTubeSubscription class],
                      [GTLYouTubeSubscriptionContentDetails class],
                      [GTLYouTubeSubscriptionListResponse class],
                      [GTLYouTubeSubscriptionSnippet class],
                      [GTLYouTubeSubscriptionSubscriberSnippet class],
                      [GTLYouTubeThumbnail class],
                      [GTLYouTubeThumbnailDetails class],
                      [GTLYouTubeThumbnailSetResponse class],
                      [GTLYouTubeTokenPagination class],
                      [GTLYouTubeVideo class],
                      [GTLYouTubeVideoAgeGating class],
                      [GTLYouTubeVideoCategory class],
                      [GTLYouTubeVideoCategoryListResponse class],
                      [GTLYouTubeVideoCategorySnippet class],
                      [GTLYouTubeVideoContentDetails class],
                      [GTLYouTubeVideoContentDetailsRegionRestriction class],
                      [GTLYouTubeVideoConversionPing class],
                      [GTLYouTubeVideoConversionPings class],
                      [GTLYouTubeVideoFileDetails class],
                      [GTLYouTubeVideoFileDetailsAudioStream class],
                      [GTLYouTubeVideoFileDetailsVideoStream class],
                      [GTLYouTubeVideoGetRatingResponse class],
                      [GTLYouTubeVideoListResponse class],
                      [GTLYouTubeVideoLiveStreamingDetails class],
                      [GTLYouTubeVideoMonetizationDetails class],
                      [GTLYouTubeVideoPlayer class],
                      [GTLYouTubeVideoProcessingDetails class],
                      [GTLYouTubeVideoProcessingDetailsProcessingProgress class],
                      [GTLYouTubeVideoProjectDetails class],
                      [GTLYouTubeVideoRating class],
                      [GTLYouTubeVideoRecordingDetails class],
                      [GTLYouTubeVideoSnippet class],
                      [GTLYouTubeVideoStatistics class],
                      [GTLYouTubeVideoStatus class],
                      [GTLYouTubeVideoSuggestions class],
                      [GTLYouTubeVideoSuggestionsTagSuggestion class],
                      [GTLYouTubeVideoTopicDetails class],
                      [GTLYouTubeWatchSettings class],
                      nil];
  return classes;
}
#endif  // DEBUG

- (id)init {
  self = [super init];
  if (self) {
    // Version from discovery.
    self.apiVersion = @"v3";

    // From discovery.  Where to send JSON-RPC.
    // Turn off prettyPrint for this service to save bandwidth (especially on
    // mobile). The fetcher logging will pretty print.
    self.rpcURL = [NSURL URLWithString:@"https://www.googleapis.com/rpc?prettyPrint=false"];
    self.rpcUploadURL = [NSURL URLWithString:@"https://www.googleapis.com/upload/rpc?uploadType=resumable&prettyPrint=false"];
  }
  return self;
}

@end

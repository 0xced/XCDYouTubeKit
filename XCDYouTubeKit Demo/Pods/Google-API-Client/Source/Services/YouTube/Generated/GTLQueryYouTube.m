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
//  GTLQueryYouTube.m
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
//   GTLQueryYouTube (45 custom class methods, 54 custom properties)

#import "GTLQueryYouTube.h"

#import "GTLYouTubeActivity.h"
#import "GTLYouTubeActivityListResponse.h"
#import "GTLYouTubeChannel.h"
#import "GTLYouTubeChannelBannerResource.h"
#import "GTLYouTubeChannelListResponse.h"
#import "GTLYouTubeChannelSection.h"
#import "GTLYouTubeChannelSectionListResponse.h"
#import "GTLYouTubeGuideCategoryListResponse.h"
#import "GTLYouTubeI18nLanguageListResponse.h"
#import "GTLYouTubeI18nRegionListResponse.h"
#import "GTLYouTubeInvideoBranding.h"
#import "GTLYouTubeLiveBroadcast.h"
#import "GTLYouTubeLiveBroadcastListResponse.h"
#import "GTLYouTubeLiveStream.h"
#import "GTLYouTubeLiveStreamListResponse.h"
#import "GTLYouTubePlaylist.h"
#import "GTLYouTubePlaylistItem.h"
#import "GTLYouTubePlaylistItemListResponse.h"
#import "GTLYouTubePlaylistListResponse.h"
#import "GTLYouTubeSearchListResponse.h"
#import "GTLYouTubeSubscription.h"
#import "GTLYouTubeSubscriptionListResponse.h"
#import "GTLYouTubeThumbnailSetResponse.h"
#import "GTLYouTubeVideo.h"
#import "GTLYouTubeVideoCategoryListResponse.h"
#import "GTLYouTubeVideoGetRatingResponse.h"
#import "GTLYouTubeVideoListResponse.h"

@implementation GTLQueryYouTube

@dynamic autoLevels, broadcastStatus, categoryId, channelId, channelType, chart,
         displaySlate, eventType, fields, forChannelId, forContentOwner,
         forMine, forUsername, hl, home, identifier, locale, location,
         locationRadius, managedByMe, maxResults, mine, myRating, mySubscribers,
         notifySubscribers, offsetTimeMs, onBehalfOfContentOwner,
         onBehalfOfContentOwnerChannel, order, pageToken, part, playlistId,
         publishedAfter, publishedBefore, q, rating, regionCode,
         relatedToVideoId, safeSearch, stabilize, streamId, topicId, type,
         videoCaption, videoCategoryId, videoDefinition, videoDimension,
         videoDuration, videoEmbeddable, videoId, videoLicense, videoSyndicated,
         videoType, walltime;

+ (NSDictionary *)parameterNameMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

#pragma mark -
#pragma mark "activities" methods
// These create a GTLQueryYouTube object.

+ (id)queryForActivitiesInsertWithObject:(GTLYouTubeActivity *)object
                                    part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.activities.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeActivity class];
  return query;
}

+ (id)queryForActivitiesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.activities.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeActivityListResponse class];
  return query;
}

#pragma mark -
#pragma mark "channelBanners" methods
// These create a GTLQueryYouTube object.

+ (id)queryForChannelBannersInsertWithObject:(GTLYouTubeChannelBannerResource *)object
                            uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.channelBanners.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLYouTubeChannelBannerResource class];
  return query;
}

#pragma mark -
#pragma mark "channelSections" methods
// These create a GTLQueryYouTube object.

+ (id)queryForChannelSectionsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.channelSections.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForChannelSectionsInsertWithObject:(GTLYouTubeChannelSection *)object
                                         part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.channelSections.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannelSection class];
  return query;
}

+ (id)queryForChannelSectionsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.channelSections.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannelSectionListResponse class];
  return query;
}

+ (id)queryForChannelSectionsUpdateWithObject:(GTLYouTubeChannelSection *)object
                                         part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.channelSections.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannelSection class];
  return query;
}

#pragma mark -
#pragma mark "channels" methods
// These create a GTLQueryYouTube object.

+ (id)queryForChannelsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.channels.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannelListResponse class];
  return query;
}

+ (id)queryForChannelsUpdateWithObject:(GTLYouTubeChannel *)object
                                  part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.channels.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannel class];
  return query;
}

#pragma mark -
#pragma mark "guideCategories" methods
// These create a GTLQueryYouTube object.

+ (id)queryForGuideCategoriesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.guideCategories.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeGuideCategoryListResponse class];
  return query;
}

#pragma mark -
#pragma mark "i18nLanguages" methods
// These create a GTLQueryYouTube object.

+ (id)queryForI18nLanguagesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.i18nLanguages.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeI18nLanguageListResponse class];
  return query;
}

#pragma mark -
#pragma mark "i18nRegions" methods
// These create a GTLQueryYouTube object.

+ (id)queryForI18nRegionsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.i18nRegions.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeI18nRegionListResponse class];
  return query;
}

#pragma mark -
#pragma mark "liveBroadcasts" methods
// These create a GTLQueryYouTube object.

+ (id)queryForLiveBroadcastsBindWithIdentifier:(NSString *)identifier
                                          part:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.bind";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

+ (id)queryForLiveBroadcastsControlWithIdentifier:(NSString *)identifier
                                             part:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.control";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

+ (id)queryForLiveBroadcastsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveBroadcasts.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForLiveBroadcastsInsertWithObject:(GTLYouTubeLiveBroadcast *)object
                                        part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveBroadcasts.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

+ (id)queryForLiveBroadcastsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcastListResponse class];
  return query;
}

+ (id)queryForLiveBroadcastsTransitionWithBroadcastStatus:(NSString *)broadcastStatus
                                               identifier:(NSString *)identifier
                                                     part:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.transition";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.broadcastStatus = broadcastStatus;
  query.identifier = identifier;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

+ (id)queryForLiveBroadcastsUpdateWithObject:(GTLYouTubeLiveBroadcast *)object
                                        part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveBroadcasts.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

#pragma mark -
#pragma mark "liveStreams" methods
// These create a GTLQueryYouTube object.

+ (id)queryForLiveStreamsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveStreams.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForLiveStreamsInsertWithObject:(GTLYouTubeLiveStream *)object
                                     part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveStreams.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveStream class];
  return query;
}

+ (id)queryForLiveStreamsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.liveStreams.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveStreamListResponse class];
  return query;
}

+ (id)queryForLiveStreamsUpdateWithObject:(GTLYouTubeLiveStream *)object
                                     part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveStreams.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveStream class];
  return query;
}

#pragma mark -
#pragma mark "playlistItems" methods
// These create a GTLQueryYouTube object.

+ (id)queryForPlaylistItemsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.playlistItems.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForPlaylistItemsInsertWithObject:(GTLYouTubePlaylistItem *)object
                                       part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.playlistItems.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylistItem class];
  return query;
}

+ (id)queryForPlaylistItemsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.playlistItems.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylistItemListResponse class];
  return query;
}

+ (id)queryForPlaylistItemsUpdateWithObject:(GTLYouTubePlaylistItem *)object
                                       part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.playlistItems.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylistItem class];
  return query;
}

#pragma mark -
#pragma mark "playlists" methods
// These create a GTLQueryYouTube object.

+ (id)queryForPlaylistsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.playlists.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForPlaylistsInsertWithObject:(GTLYouTubePlaylist *)object
                                   part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.playlists.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylist class];
  return query;
}

+ (id)queryForPlaylistsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.playlists.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylistListResponse class];
  return query;
}

+ (id)queryForPlaylistsUpdateWithObject:(GTLYouTubePlaylist *)object
                                   part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.playlists.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylist class];
  return query;
}

#pragma mark -
#pragma mark "search" methods
// These create a GTLQueryYouTube object.

+ (id)queryForSearchListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.search.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeSearchListResponse class];
  return query;
}

#pragma mark -
#pragma mark "subscriptions" methods
// These create a GTLQueryYouTube object.

+ (id)queryForSubscriptionsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.subscriptions.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForSubscriptionsInsertWithObject:(GTLYouTubeSubscription *)object
                                       part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.subscriptions.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeSubscription class];
  return query;
}

+ (id)queryForSubscriptionsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.subscriptions.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeSubscriptionListResponse class];
  return query;
}

#pragma mark -
#pragma mark "thumbnails" methods
// These create a GTLQueryYouTube object.

+ (id)queryForThumbnailsSetWithVideoId:(NSString *)videoId
                      uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  NSString *methodName = @"youtube.thumbnails.set";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.videoId = videoId;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLYouTubeThumbnailSetResponse class];
  return query;
}

#pragma mark -
#pragma mark "videoCategories" methods
// These create a GTLQueryYouTube object.

+ (id)queryForVideoCategoriesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.videoCategories.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeVideoCategoryListResponse class];
  return query;
}

#pragma mark -
#pragma mark "videos" methods
// These create a GTLQueryYouTube object.

+ (id)queryForVideosDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.videos.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForVideosGetRatingWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.videos.getRating";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLYouTubeVideoGetRatingResponse class];
  return query;
}

+ (id)queryForVideosInsertWithObject:(GTLYouTubeVideo *)object
                                part:(NSString *)part
                    uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.videos.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLYouTubeVideo class];
  return query;
}

+ (id)queryForVideosListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.videos.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeVideoListResponse class];
  return query;
}

+ (id)queryForVideosRateWithIdentifier:(NSString *)identifier
                                rating:(NSString *)rating {
  NSString *methodName = @"youtube.videos.rate";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.rating = rating;
  return query;
}

+ (id)queryForVideosUpdateWithObject:(GTLYouTubeVideo *)object
                                part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.videos.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeVideo class];
  return query;
}

#pragma mark -
#pragma mark "watermarks" methods
// These create a GTLQueryYouTube object.

+ (id)queryForWatermarksSetWithObject:(GTLYouTubeInvideoBranding *)object
                            channelId:(NSString *)channelId
                     uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.watermarks.set";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.channelId = channelId;
  query.uploadParameters = uploadParametersOrNil;
  return query;
}

+ (id)queryForWatermarksUnsetWithChannelId:(NSString *)channelId {
  NSString *methodName = @"youtube.watermarks.unset";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.channelId = channelId;
  return query;
}

@end

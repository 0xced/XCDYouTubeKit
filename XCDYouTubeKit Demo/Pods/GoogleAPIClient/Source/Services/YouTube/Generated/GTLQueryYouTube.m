/* Copyright (c) 2016 Google Inc.
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
//   GTLQueryYouTube (71 custom class methods, 71 custom properties)

#import "GTLQueryYouTube.h"

#import "GTLYouTubeActivity.h"
#import "GTLYouTubeActivityListResponse.h"
#import "GTLYouTubeCaption.h"
#import "GTLYouTubeCaptionListResponse.h"
#import "GTLYouTubeChannel.h"
#import "GTLYouTubeChannelBannerResource.h"
#import "GTLYouTubeChannelListResponse.h"
#import "GTLYouTubeChannelSection.h"
#import "GTLYouTubeChannelSectionListResponse.h"
#import "GTLYouTubeComment.h"
#import "GTLYouTubeCommentListResponse.h"
#import "GTLYouTubeCommentThread.h"
#import "GTLYouTubeCommentThreadListResponse.h"
#import "GTLYouTubeFanFundingEventListResponse.h"
#import "GTLYouTubeGuideCategoryListResponse.h"
#import "GTLYouTubeI18nLanguageListResponse.h"
#import "GTLYouTubeI18nRegionListResponse.h"
#import "GTLYouTubeInvideoBranding.h"
#import "GTLYouTubeLiveBroadcast.h"
#import "GTLYouTubeLiveBroadcastListResponse.h"
#import "GTLYouTubeLiveChatBan.h"
#import "GTLYouTubeLiveChatMessage.h"
#import "GTLYouTubeLiveChatMessageListResponse.h"
#import "GTLYouTubeLiveChatModerator.h"
#import "GTLYouTubeLiveChatModeratorListResponse.h"
#import "GTLYouTubeLiveStream.h"
#import "GTLYouTubeLiveStreamListResponse.h"
#import "GTLYouTubePlaylist.h"
#import "GTLYouTubePlaylistItem.h"
#import "GTLYouTubePlaylistItemListResponse.h"
#import "GTLYouTubePlaylistListResponse.h"
#import "GTLYouTubeSearchListResponse.h"
#import "GTLYouTubeSponsorListResponse.h"
#import "GTLYouTubeSubscription.h"
#import "GTLYouTubeSubscriptionListResponse.h"
#import "GTLYouTubeThumbnailSetResponse.h"
#import "GTLYouTubeVideo.h"
#import "GTLYouTubeVideoAbuseReport.h"
#import "GTLYouTubeVideoAbuseReportReasonListResponse.h"
#import "GTLYouTubeVideoCategoryListResponse.h"
#import "GTLYouTubeVideoGetRatingResponse.h"
#import "GTLYouTubeVideoListResponse.h"

@implementation GTLQueryYouTube

@dynamic allThreadsRelatedToChannelId, autoLevels, banAuthor, broadcastStatus,
         broadcastType, categoryId, channelId, channelType, chart, displaySlate,
         eventType, fields, filter, forChannelId, forContentOwner, forDeveloper,
         forMine, forUsername, hl, home, identifier, liveChatId, locale,
         location, locationRadius, managedByMe, maxResults, mine,
         moderationStatus, myRating, mySubscribers, notifySubscribers,
         offsetTimeMs, onBehalfOf, onBehalfOfContentOwner,
         onBehalfOfContentOwnerChannel, order, pageToken, parentId, part,
         playlistId, profileImageSize, publishedAfter, publishedBefore, q,
         rating, regionCode, relatedToVideoId, relevanceLanguage, report,
         safeSearch, searchTerms, stabilize, streamId, sync, textFormat, tfmt,
         tlang, topicId, type, videoCaption, videoCategoryId, videoDefinition,
         videoDimension, videoDuration, videoEmbeddable, videoId, videoLicense,
         videoSyndicated, videoType, walltime;

+ (NSDictionary *)parameterNameMap {
  NSDictionary *map = @{
    @"identifier" : @"id"
  };
  return map;
}

#pragma mark - "activities" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForActivitiesInsertWithObject:(GTLYouTubeActivity *)object
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

+ (instancetype)queryForActivitiesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.activities.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeActivityListResponse class];
  return query;
}

#pragma mark - "captions" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForCaptionsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.captions.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForCaptionsDownloadWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.captions.download";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForCaptionsInsertWithObject:(GTLYouTubeCaption *)object
                                            part:(NSString *)part
                                uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.captions.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLYouTubeCaption class];
  return query;
}

+ (instancetype)queryForCaptionsListWithPart:(NSString *)part
                                     videoId:(NSString *)videoId {
  NSString *methodName = @"youtube.captions.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.videoId = videoId;
  query.expectedObjectClass = [GTLYouTubeCaptionListResponse class];
  return query;
}

+ (instancetype)queryForCaptionsUpdateWithObject:(GTLYouTubeCaption *)object
                                            part:(NSString *)part
                                uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.captions.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLYouTubeCaption class];
  return query;
}

#pragma mark - "channelBanners" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForChannelBannersInsertWithObject:(GTLYouTubeChannelBannerResource *)object
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

#pragma mark - "channelSections" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForChannelSectionsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.channelSections.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForChannelSectionsInsertWithObject:(GTLYouTubeChannelSection *)object
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

+ (instancetype)queryForChannelSectionsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.channelSections.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannelSectionListResponse class];
  return query;
}

+ (instancetype)queryForChannelSectionsUpdateWithObject:(GTLYouTubeChannelSection *)object
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

#pragma mark - "channels" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForChannelsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.channels.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeChannelListResponse class];
  return query;
}

+ (instancetype)queryForChannelsUpdateWithObject:(GTLYouTubeChannel *)object
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

#pragma mark - "comments" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForCommentsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.comments.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForCommentsInsertWithObject:(GTLYouTubeComment *)object
                                            part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.comments.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeComment class];
  return query;
}

+ (instancetype)queryForCommentsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.comments.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeCommentListResponse class];
  return query;
}

+ (instancetype)queryForCommentsMarkAsSpamWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.comments.markAsSpam";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForCommentsSetModerationStatusWithIdentifier:(NSString *)identifier
                                                 moderationStatus:(NSString *)moderationStatus {
  NSString *methodName = @"youtube.comments.setModerationStatus";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.moderationStatus = moderationStatus;
  return query;
}

+ (instancetype)queryForCommentsUpdateWithObject:(GTLYouTubeComment *)object
                                            part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.comments.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeComment class];
  return query;
}

#pragma mark - "commentThreads" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForCommentThreadsInsertWithObject:(GTLYouTubeCommentThread *)object
                                                  part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.commentThreads.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeCommentThread class];
  return query;
}

+ (instancetype)queryForCommentThreadsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.commentThreads.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeCommentThreadListResponse class];
  return query;
}

+ (instancetype)queryForCommentThreadsUpdateWithObject:(GTLYouTubeCommentThread *)object
                                                  part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.commentThreads.update";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeCommentThread class];
  return query;
}

#pragma mark - "fanFundingEvents" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForFanFundingEventsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.fanFundingEvents.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeFanFundingEventListResponse class];
  return query;
}

#pragma mark - "guideCategories" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForGuideCategoriesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.guideCategories.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeGuideCategoryListResponse class];
  return query;
}

#pragma mark - "i18nLanguages" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForI18nLanguagesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.i18nLanguages.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeI18nLanguageListResponse class];
  return query;
}

#pragma mark - "i18nRegions" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForI18nRegionsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.i18nRegions.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeI18nRegionListResponse class];
  return query;
}

#pragma mark - "liveBroadcasts" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForLiveBroadcastsBindWithIdentifier:(NSString *)identifier
                                                    part:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.bind";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

+ (instancetype)queryForLiveBroadcastsControlWithIdentifier:(NSString *)identifier
                                                       part:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.control";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcast class];
  return query;
}

+ (instancetype)queryForLiveBroadcastsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveBroadcasts.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForLiveBroadcastsInsertWithObject:(GTLYouTubeLiveBroadcast *)object
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

+ (instancetype)queryForLiveBroadcastsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.liveBroadcasts.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveBroadcastListResponse class];
  return query;
}

+ (instancetype)queryForLiveBroadcastsTransitionWithBroadcastStatus:(NSString *)broadcastStatus
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

+ (instancetype)queryForLiveBroadcastsUpdateWithObject:(GTLYouTubeLiveBroadcast *)object
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

#pragma mark - "liveChatBans" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForLiveChatBansDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveChatBans.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForLiveChatBansInsertWithObject:(GTLYouTubeLiveChatBan *)object
                                                part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveChatBans.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveChatBan class];
  return query;
}

#pragma mark - "liveChatMessages" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForLiveChatMessagesDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveChatMessages.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForLiveChatMessagesInsertWithObject:(GTLYouTubeLiveChatMessage *)object
                                                    part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveChatMessages.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveChatMessage class];
  return query;
}

+ (instancetype)queryForLiveChatMessagesListWithLiveChatId:(NSString *)liveChatId
                                                      part:(NSString *)part {
  NSString *methodName = @"youtube.liveChatMessages.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.liveChatId = liveChatId;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveChatMessageListResponse class];
  return query;
}

#pragma mark - "liveChatModerators" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForLiveChatModeratorsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveChatModerators.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForLiveChatModeratorsInsertWithObject:(GTLYouTubeLiveChatModerator *)object
                                                      part:(NSString *)part {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"youtube.liveChatModerators.insert";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveChatModerator class];
  return query;
}

+ (instancetype)queryForLiveChatModeratorsListWithLiveChatId:(NSString *)liveChatId
                                                        part:(NSString *)part {
  NSString *methodName = @"youtube.liveChatModerators.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.liveChatId = liveChatId;
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveChatModeratorListResponse class];
  return query;
}

#pragma mark - "liveStreams" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForLiveStreamsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.liveStreams.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForLiveStreamsInsertWithObject:(GTLYouTubeLiveStream *)object
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

+ (instancetype)queryForLiveStreamsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.liveStreams.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeLiveStreamListResponse class];
  return query;
}

+ (instancetype)queryForLiveStreamsUpdateWithObject:(GTLYouTubeLiveStream *)object
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

#pragma mark - "playlistItems" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForPlaylistItemsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.playlistItems.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForPlaylistItemsInsertWithObject:(GTLYouTubePlaylistItem *)object
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

+ (instancetype)queryForPlaylistItemsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.playlistItems.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylistItemListResponse class];
  return query;
}

+ (instancetype)queryForPlaylistItemsUpdateWithObject:(GTLYouTubePlaylistItem *)object
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

#pragma mark - "playlists" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForPlaylistsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.playlists.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForPlaylistsInsertWithObject:(GTLYouTubePlaylist *)object
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

+ (instancetype)queryForPlaylistsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.playlists.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubePlaylistListResponse class];
  return query;
}

+ (instancetype)queryForPlaylistsUpdateWithObject:(GTLYouTubePlaylist *)object
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

#pragma mark - "search" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForSearchListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.search.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeSearchListResponse class];
  return query;
}

#pragma mark - "sponsors" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForSponsorsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.sponsors.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeSponsorListResponse class];
  return query;
}

#pragma mark - "subscriptions" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForSubscriptionsDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.subscriptions.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForSubscriptionsInsertWithObject:(GTLYouTubeSubscription *)object
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

+ (instancetype)queryForSubscriptionsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.subscriptions.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeSubscriptionListResponse class];
  return query;
}

#pragma mark - "thumbnails" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForThumbnailsSetWithVideoId:(NSString *)videoId
                                uploadParameters:(GTLUploadParameters *)uploadParametersOrNil {
  NSString *methodName = @"youtube.thumbnails.set";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.videoId = videoId;
  query.uploadParameters = uploadParametersOrNil;
  query.expectedObjectClass = [GTLYouTubeThumbnailSetResponse class];
  return query;
}

#pragma mark - "videoAbuseReportReasons" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForVideoAbuseReportReasonsListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.videoAbuseReportReasons.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeVideoAbuseReportReasonListResponse class];
  return query;
}

#pragma mark - "videoCategories" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForVideoCategoriesListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.videoCategories.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeVideoCategoryListResponse class];
  return query;
}

#pragma mark - "videos" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForVideosDeleteWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.videos.delete";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (instancetype)queryForVideosGetRatingWithIdentifier:(NSString *)identifier {
  NSString *methodName = @"youtube.videos.getRating";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLYouTubeVideoGetRatingResponse class];
  return query;
}

+ (instancetype)queryForVideosInsertWithObject:(GTLYouTubeVideo *)object
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

+ (instancetype)queryForVideosListWithPart:(NSString *)part {
  NSString *methodName = @"youtube.videos.list";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.part = part;
  query.expectedObjectClass = [GTLYouTubeVideoListResponse class];
  return query;
}

+ (instancetype)queryForVideosRateWithIdentifier:(NSString *)identifier
                                          rating:(NSString *)rating {
  NSString *methodName = @"youtube.videos.rate";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.rating = rating;
  return query;
}

+ (instancetype)queryForVideosReportAbuse {
  NSString *methodName = @"youtube.videos.reportAbuse";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  return query;
}

+ (instancetype)queryForVideosUpdateWithObject:(GTLYouTubeVideo *)object
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

#pragma mark - "watermarks" methods
// These create a GTLQueryYouTube object.

+ (instancetype)queryForWatermarksSetWithObject:(GTLYouTubeInvideoBranding *)object
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

+ (instancetype)queryForWatermarksUnsetWithChannelId:(NSString *)channelId {
  NSString *methodName = @"youtube.watermarks.unset";
  GTLQueryYouTube *query = [self queryWithMethodName:methodName];
  query.channelId = channelId;
  return query;
}

@end

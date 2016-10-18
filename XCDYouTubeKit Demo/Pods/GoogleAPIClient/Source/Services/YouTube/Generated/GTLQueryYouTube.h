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
//  GTLQueryYouTube.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Supports core YouTube features, such as uploading videos, creating and
//   managing playlists, searching for content, and much more.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLQueryYouTube (71 custom class methods, 71 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLQuery.h"
#else
  #import "GTLQuery.h"
#endif

@class GTLYouTubeActivity;
@class GTLYouTubeCaption;
@class GTLYouTubeChannel;
@class GTLYouTubeChannelBannerResource;
@class GTLYouTubeChannelSection;
@class GTLYouTubeComment;
@class GTLYouTubeCommentThread;
@class GTLYouTubeInvideoBranding;
@class GTLYouTubeLiveBroadcast;
@class GTLYouTubeLiveChatBan;
@class GTLYouTubeLiveChatMessage;
@class GTLYouTubeLiveChatModerator;
@class GTLYouTubeLiveStream;
@class GTLYouTubePlaylist;
@class GTLYouTubePlaylistItem;
@class GTLYouTubeSubscription;
@class GTLYouTubeVideo;
@class GTLYouTubeVideoAbuseReport;

@interface GTLQueryYouTube : GTLQuery

//
// Parameters valid on all methods.
//

// Selector specifying which fields to include in a partial response.
@property (nonatomic, copy) NSString *fields;

//
// Method-specific parameters; see the comments below for more information.
//
@property (nonatomic, copy) NSString *allThreadsRelatedToChannelId;
@property (nonatomic, assign) BOOL autoLevels;
@property (nonatomic, assign) BOOL banAuthor;
@property (nonatomic, copy) NSString *broadcastStatus;
@property (nonatomic, copy) NSString *broadcastType;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *channelType;
@property (nonatomic, copy) NSString *chart;
@property (nonatomic, assign) BOOL displaySlate;
@property (nonatomic, copy) NSString *eventType;
@property (nonatomic, copy) NSString *filter;
@property (nonatomic, copy) NSString *forChannelId;
@property (nonatomic, assign) BOOL forContentOwner;
@property (nonatomic, assign) BOOL forDeveloper;
@property (nonatomic, assign) BOOL forMine;
@property (nonatomic, copy) NSString *forUsername;
@property (nonatomic, copy) NSString *hl;
@property (nonatomic, assign) BOOL home;
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *liveChatId;
@property (nonatomic, copy) NSString *locale;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *locationRadius;
@property (nonatomic, assign) BOOL managedByMe;
@property (nonatomic, assign) NSUInteger maxResults;
@property (nonatomic, assign) BOOL mine;
@property (nonatomic, copy) NSString *moderationStatus;
@property (nonatomic, copy) NSString *myRating;
@property (nonatomic, assign) BOOL mySubscribers;
@property (nonatomic, assign) BOOL notifySubscribers;
@property (nonatomic, assign) unsigned long long offsetTimeMs;
@property (nonatomic, copy) NSString *onBehalfOf;
@property (nonatomic, copy) NSString *onBehalfOfContentOwner;
@property (nonatomic, copy) NSString *onBehalfOfContentOwnerChannel;
@property (nonatomic, copy) NSString *order;
@property (nonatomic, copy) NSString *pageToken;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *part;
@property (nonatomic, copy) NSString *playlistId;
@property (nonatomic, assign) NSUInteger profileImageSize;
@property (nonatomic, retain) GTLDateTime *publishedAfter;
@property (nonatomic, retain) GTLDateTime *publishedBefore;
@property (nonatomic, copy) NSString *q;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic, copy) NSString *relatedToVideoId;
@property (nonatomic, copy) NSString *relevanceLanguage;
@property (nonatomic, retain) GTLYouTubeVideoAbuseReport *report;
@property (nonatomic, copy) NSString *safeSearch;
@property (nonatomic, copy) NSString *searchTerms;
@property (nonatomic, assign) BOOL stabilize;
@property (nonatomic, copy) NSString *streamId;
@property (nonatomic, assign) BOOL sync;
@property (nonatomic, copy) NSString *textFormat;
@property (nonatomic, copy) NSString *tfmt;
@property (nonatomic, copy) NSString *tlang;
@property (nonatomic, copy) NSString *topicId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *videoCaption;
@property (nonatomic, copy) NSString *videoCategoryId;
@property (nonatomic, copy) NSString *videoDefinition;
@property (nonatomic, copy) NSString *videoDimension;
@property (nonatomic, copy) NSString *videoDuration;
@property (nonatomic, copy) NSString *videoEmbeddable;
@property (nonatomic, copy) NSString *videoId;
@property (nonatomic, copy) NSString *videoLicense;
@property (nonatomic, copy) NSString *videoSyndicated;
@property (nonatomic, copy) NSString *videoType;
@property (nonatomic, retain) GTLDateTime *walltime;

#pragma mark - "activities" methods
// These create a GTLQueryYouTube object.

// Method: youtube.activities.insert
// Posts a bulletin for a specific channel. (The user submitting the request
// must be authorized to act on the channel's behalf.)
// Note: Even though an activity resource can contain information about actions
// like a user rating a video or marking a video as a favorite, you need to use
// other API methods to generate those activity resources. For example, you
// would use the API's videos.rate() method to rate a video and the
// playlistItems.insert() method to mark a video as a favorite.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeActivity.
+ (instancetype)queryForActivitiesInsertWithObject:(GTLYouTubeActivity *)object
                                              part:(NSString *)part;

// Method: youtube.activities.list
// Returns a list of channel activity events that match the request criteria.
// For example, you can retrieve events associated with a particular channel,
// events associated with the user's subscriptions and Google+ friends, or the
// YouTube home page feed, which is customized for each user.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     activity resource properties that the API response will include.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in an
//     activity resource, the snippet property contains other properties that
//     identify the type of activity, a display title for the activity, and so
//     forth. If you set part=snippet, the API response will also contain all of
//     those nested properties.
//  Optional:
//   channelId: The channelId parameter specifies a unique YouTube channel ID.
//     The API will then return a list of that channel's activities.
//   home: Set this parameter's value to true to retrieve the activity feed that
//     displays on the YouTube home page for the currently authenticated user.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   mine: Set this parameter's value to true to retrieve a feed of the
//     authenticated user's activities.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//   publishedAfter: The publishedAfter parameter specifies the earliest date
//     and time that an activity could have occurred for that activity to be
//     included in the API response. If the parameter value specifies a day, but
//     not a time, then any activities that occurred that day will be included
//     in the result set. The value is specified in ISO 8601
//     (YYYY-MM-DDThh:mm:ss.sZ) format.
//   publishedBefore: The publishedBefore parameter specifies the date and time
//     before which an activity must have occurred for that activity to be
//     included in the API response. If the parameter value specifies a day, but
//     not a time, then any activities that occurred that day will be excluded
//     from the result set. The value is specified in ISO 8601
//     (YYYY-MM-DDThh:mm:ss.sZ) format.
//   regionCode: The regionCode parameter instructs the API to return results
//     for the specified country. The parameter value is an ISO 3166-1 alpha-2
//     country code. YouTube uses this value when the authorized user's previous
//     activity on YouTube does not provide enough information to generate the
//     activity feed.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeActivityListResponse.
+ (instancetype)queryForActivitiesListWithPart:(NSString *)part;

#pragma mark - "captions" methods
// These create a GTLQueryYouTube object.

// Method: youtube.captions.delete
// Deletes a specified caption track.
//  Required:
//   identifier: The id parameter identifies the caption track that is being
//     deleted. The value is a caption track ID as identified by the id property
//     in a caption resource.
//  Optional:
//   onBehalfOf: ID of the Google+ Page for the channel that the request is be
//     on behalf of
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForCaptionsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.captions.download
// Downloads a caption track. The caption track is returned in its original
// format unless the request specifies a value for the tfmt parameter and in its
// original language unless the request specifies a value for the tlang
// parameter.
//  Required:
//   identifier: The id parameter identifies the caption track that is being
//     retrieved. The value is a caption track ID as identified by the id
//     property in a caption resource.
//  Optional:
//   onBehalfOf: ID of the Google+ Page for the channel that the request is be
//     on behalf of
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   tfmt: The tfmt parameter specifies that the caption track should be
//     returned in a specific format. If the parameter is not included in the
//     request, the track is returned in its original format.
//      kGTLYouTubeTfmtSbv: SubViewer subtitle.
//      kGTLYouTubeTfmtScc: Scenarist Closed Caption format.
//      kGTLYouTubeTfmtSrt: SubRip subtitle.
//      kGTLYouTubeTfmtTtml: Timed Text Markup Language caption.
//      kGTLYouTubeTfmtVtt: Web Video Text Tracks caption.
//   tlang: The tlang parameter specifies that the API response should return a
//     translation of the specified caption track. The parameter value is an ISO
//     639-1 two-letter language code that identifies the desired caption
//     language. The translation is generated by using machine translation, such
//     as Google Translate.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForCaptionsDownloadWithIdentifier:(NSString *)identifier;

// Method: youtube.captions.insert
// Uploads a caption track.
//  Required:
//   part: The part parameter specifies the caption resource parts that the API
//     response will include. Set the parameter value to snippet.
//  Optional:
//   onBehalfOf: ID of the Google+ Page for the channel that the request is be
//     on behalf of
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   sync: The sync parameter indicates whether YouTube should automatically
//     synchronize the caption file with the audio track of the video. If you
//     set the value to true, YouTube will disregard any time codes that are in
//     the uploaded caption file and generate new time codes for the captions.
//     You should set the sync parameter to true if you are uploading a
//     transcript, which has no time codes, or if you suspect the time codes in
//     your file are incorrect and want YouTube to try to fix them.
//  Upload Parameters:
//   Maximum size: 100MB
//   Accepted MIME type(s): */*, application/octet-stream, text/xml
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeCaption.
+ (instancetype)queryForCaptionsInsertWithObject:(GTLYouTubeCaption *)object
                                            part:(NSString *)part
                                uploadParameters:(GTLUploadParameters *)uploadParametersOrNil;

// Method: youtube.captions.list
// Returns a list of caption tracks that are associated with a specified video.
// Note that the API response does not contain the actual captions and that the
// captions.download method provides the ability to retrieve a caption track.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     caption resource parts that the API response will include. The part names
//     that you can include in the parameter value are id and snippet.
//   videoId: The videoId parameter specifies the YouTube video ID of the video
//     for which the API should return caption tracks.
//  Optional:
//   identifier: The id parameter specifies a comma-separated list of IDs that
//     identify the caption resources that should be retrieved. Each ID must
//     identify a caption track associated with the specified video.
//   onBehalfOf: ID of the Google+ Page for the channel that the request is on
//     behalf of.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeCaptionListResponse.
+ (instancetype)queryForCaptionsListWithPart:(NSString *)part
                                     videoId:(NSString *)videoId;

// Method: youtube.captions.update
// Updates a caption track. When updating a caption track, you can change the
// track's draft status, upload a new caption file for the track, or both.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include. Set the property value
//     to snippet if you are updating the track's draft status. Otherwise, set
//     the property value to id.
//  Optional:
//   onBehalfOf: ID of the Google+ Page for the channel that the request is be
//     on behalf of
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   sync: Note: The API server only processes the parameter value if the
//     request contains an updated caption file.
//     The sync parameter indicates whether YouTube should automatically
//     synchronize the caption file with the audio track of the video. If you
//     set the value to true, YouTube will automatically synchronize the caption
//     track with the audio track.
//  Upload Parameters:
//   Maximum size: 100MB
//   Accepted MIME type(s): */*, application/octet-stream, text/xml
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeCaption.
+ (instancetype)queryForCaptionsUpdateWithObject:(GTLYouTubeCaption *)object
                                            part:(NSString *)part
                                uploadParameters:(GTLUploadParameters *)uploadParametersOrNil;

#pragma mark - "channelBanners" methods
// These create a GTLQueryYouTube object.

// Method: youtube.channelBanners.insert
// Uploads a channel banner image to YouTube. This method represents the first
// two steps in a three-step process to update the banner image for a channel:
// - Call the channelBanners.insert method to upload the binary image data to
// YouTube. The image must have a 16:9 aspect ratio and be at least 2120x1192
// pixels.
// - Extract the url property's value from the response that the API returns for
// step 1.
// - Call the channels.update method to update the channel's branding settings.
// Set the brandingSettings.image.bannerExternalUrl property's value to the URL
// obtained in step 2.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Upload Parameters:
//   Maximum size: 6MB
//   Accepted MIME type(s): application/octet-stream, image/jpeg, image/png
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeUpload
// Fetches a GTLYouTubeChannelBannerResource.
+ (instancetype)queryForChannelBannersInsertWithObject:(GTLYouTubeChannelBannerResource *)object
                                      uploadParameters:(GTLUploadParameters *)uploadParametersOrNil;

#pragma mark - "channelSections" methods
// These create a GTLQueryYouTube object.

// Method: youtube.channelSections.delete
// Deletes a channelSection.
//  Required:
//   identifier: The id parameter specifies the YouTube channelSection ID for
//     the resource that is being deleted. In a channelSection resource, the id
//     property specifies the YouTube channelSection ID.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForChannelSectionsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.channelSections.insert
// Adds a channelSection for the authenticated user's channel.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The part names that you can include in the parameter value are snippet
//     and contentDetails.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeChannelSection.
+ (instancetype)queryForChannelSectionsInsertWithObject:(GTLYouTubeChannelSection *)object
                                                   part:(NSString *)part;

// Method: youtube.channelSections.list
// Returns channelSection resources that match the API request criteria.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     channelSection resource properties that the API response will include.
//     The part names that you can include in the parameter value are id,
//     snippet, and contentDetails.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in a
//     channelSection resource, the snippet property contains other properties,
//     such as a display title for the channelSection. If you set part=snippet,
//     the API response will also contain all of those nested properties.
//  Optional:
//   channelId: The channelId parameter specifies a YouTube channel ID. The API
//     will only return that channel's channelSections.
//   hl: The hl parameter indicates that the snippet.localized property values
//     in the returned channelSection resources should be in the specified
//     language if localized values for that language are available. For
//     example, if the API request specifies hl=de, the snippet.localized
//     properties in the API response will contain German titles if German
//     titles are available. Channel owners can provide localized channel
//     section titles using either the channelSections.insert or
//     channelSections.update method.
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube channelSection ID(s) for the resource(s) that are being
//     retrieved. In a channelSection resource, the id property specifies the
//     YouTube channelSection ID.
//   mine: Set this parameter's value to true to retrieve a feed of the
//     authenticated user's channelSections.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeChannelSectionListResponse.
+ (instancetype)queryForChannelSectionsListWithPart:(NSString *)part;

// Method: youtube.channelSections.update
// Update a channelSection.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The part names that you can include in the parameter value are snippet
//     and contentDetails.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeChannelSection.
+ (instancetype)queryForChannelSectionsUpdateWithObject:(GTLYouTubeChannelSection *)object
                                                   part:(NSString *)part;

#pragma mark - "channels" methods
// These create a GTLQueryYouTube object.

// Method: youtube.channels.list
// Returns a collection of zero or more channel resources that match the request
// criteria.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     channel resource properties that the API response will include.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in a
//     channel resource, the contentDetails property contains other properties,
//     such as the uploads properties. As such, if you set part=contentDetails,
//     the API response will also contain all of those nested properties.
//  Optional:
//   categoryId: The categoryId parameter specifies a YouTube guide category,
//     thereby requesting YouTube channels associated with that category.
//   forUsername: The forUsername parameter specifies a YouTube username,
//     thereby requesting the channel associated with that username.
//   hl: The hl parameter should be used for filter out the properties that are
//     not in the given language. Used for the brandingSettings part.
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube channel ID(s) for the resource(s) that are being retrieved. In a
//     channel resource, the id property specifies the channel's YouTube channel
//     ID.
//   managedByMe: Note: This parameter is intended exclusively for YouTube
//     content partners.
//     Set this parameter's value to true to instruct the API to only return
//     channels managed by the content owner that the onBehalfOfContentOwner
//     parameter specifies. The user must be authenticated as a CMS account
//     linked to the specified content owner and onBehalfOfContentOwner must be
//     provided.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   mine: Set this parameter's value to true to instruct the API to only return
//     channels owned by the authenticated user.
//   mySubscribers: Use the subscriptions.list method and its mySubscribers
//     parameter to retrieve a list of subscribers to the authenticated user's
//     channel.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
//   kGTLAuthScopeYouTubeYoutubepartnerChannelAudit
// Fetches a GTLYouTubeChannelListResponse.
+ (instancetype)queryForChannelsListWithPart:(NSString *)part;

// Method: youtube.channels.update
// Updates a channel's metadata. Note that this method currently only supports
// updates to the channel resource's brandingSettings and invideoPromotion
// objects and their child properties.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The API currently only allows the parameter value to be set to either
//     brandingSettings or invideoPromotion. (You cannot update both of those
//     parts with a single request.)
//     Note that this method overrides the existing values for all of the
//     mutable properties that are contained in any parts that the parameter
//     value specifies.
//  Optional:
//   onBehalfOfContentOwner: The onBehalfOfContentOwner parameter indicates that
//     the authenticated user is acting on behalf of the content owner specified
//     in the parameter value. This parameter is intended for YouTube content
//     partners that own and manage many different YouTube channels. It allows
//     content owners to authenticate once and get access to all their video and
//     channel data, without having to provide authentication credentials for
//     each individual channel. The actual CMS account that the user
//     authenticates with needs to be linked to the specified YouTube content
//     owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeChannel.
+ (instancetype)queryForChannelsUpdateWithObject:(GTLYouTubeChannel *)object
                                            part:(NSString *)part;

#pragma mark - "comments" methods
// These create a GTLQueryYouTube object.

// Method: youtube.comments.delete
// Deletes a comment.
//  Required:
//   identifier: The id parameter specifies the comment ID for the resource that
//     is being deleted.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForCommentsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.comments.insert
// Creates a reply to an existing comment. Note: To create a top-level comment,
// use the commentThreads.insert method.
//  Required:
//   part: The part parameter identifies the properties that the API response
//     will include. Set the parameter value to snippet. The snippet part has a
//     quota cost of 2 units.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeComment.
+ (instancetype)queryForCommentsInsertWithObject:(GTLYouTubeComment *)object
                                            part:(NSString *)part;

// Method: youtube.comments.list
// Returns a list of comments that match the API request parameters.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     comment resource properties that the API response will include.
//  Optional:
//   identifier: The id parameter specifies a comma-separated list of comment
//     IDs for the resources that are being retrieved. In a comment resource,
//     the id property specifies the comment's ID.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set.
//     Note: This parameter is not supported for use in conjunction with the id
//     parameter. (1..100, default 20)
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken
//     property identifies the next page of the result that can be retrieved.
//     Note: This parameter is not supported for use in conjunction with the id
//     parameter.
//   parentId: The parentId parameter specifies the ID of the comment for which
//     replies should be retrieved.
//     Note: YouTube currently supports replies only for top-level comments.
//     However, replies to replies may be supported in the future.
//   textFormat: This parameter indicates whether the API should return comments
//     formatted as HTML or as plain text. (Default "FORMAT_HTML")
//      kGTLYouTubeTextFormatHtml: Returns the comments in HTML format. This is
//        the default value.
//      kGTLYouTubeTextFormatPlainText: Returns the comments in plain text
//        format.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeCommentListResponse.
+ (instancetype)queryForCommentsListWithPart:(NSString *)part;

// Method: youtube.comments.markAsSpam
// Expresses the caller's opinion that one or more comments should be flagged as
// spam.
//  Required:
//   identifier: The id parameter specifies a comma-separated list of IDs of
//     comments that the caller believes should be classified as spam.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForCommentsMarkAsSpamWithIdentifier:(NSString *)identifier;

// Method: youtube.comments.setModerationStatus
// Sets the moderation status of one or more comments. The API request must be
// authorized by the owner of the channel or video associated with the comments.
//  Required:
//   identifier: The id parameter specifies a comma-separated list of IDs that
//     identify the comments for which you are updating the moderation status.
//   moderationStatus: Identifies the new moderation status of the specified
//     comments.
//      kGTLYouTubeModerationStatusHeldForReview: Marks a comment as awaiting
//        review by a moderator.
//      kGTLYouTubeModerationStatusPublished: Clears a comment for public
//        display.
//      kGTLYouTubeModerationStatusRejected: Rejects a comment as being unfit
//        for display. This action also effectively hides all replies to the
//        rejected comment.
//        Note: The API does not currently provide a way to list or otherwise
//        discover rejected comments. However, you can change the moderation
//        status of a rejected comment if you still know its ID. If you were to
//        change the moderation status of a rejected comment, the comment
//        replies would subsequently be discoverable again as well.
//  Optional:
//   banAuthor: The banAuthor parameter lets you indicate that you want to
//     automatically reject any additional comments written by the comment's
//     author. Set the parameter value to true to ban the author.
//     Note: This parameter is only valid if the moderationStatus parameter is
//     also set to rejected. (Default false)
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForCommentsSetModerationStatusWithIdentifier:(NSString *)identifier
                                                 moderationStatus:(NSString *)moderationStatus;

// Method: youtube.comments.update
// Modifies a comment.
//  Required:
//   part: The part parameter identifies the properties that the API response
//     will include. You must at least include the snippet part in the parameter
//     value since that part contains all of the properties that the API request
//     can update.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeComment.
+ (instancetype)queryForCommentsUpdateWithObject:(GTLYouTubeComment *)object
                                            part:(NSString *)part;

#pragma mark - "commentThreads" methods
// These create a GTLQueryYouTube object.

// Method: youtube.commentThreads.insert
// Creates a new top-level comment. To add a reply to an existing comment, use
// the comments.insert method instead.
//  Required:
//   part: The part parameter identifies the properties that the API response
//     will include. Set the parameter value to snippet. The snippet part has a
//     quota cost of 2 units.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeCommentThread.
+ (instancetype)queryForCommentThreadsInsertWithObject:(GTLYouTubeCommentThread *)object
                                                  part:(NSString *)part;

// Method: youtube.commentThreads.list
// Returns a list of comment threads that match the API request parameters.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     commentThread resource properties that the API response will include.
//  Optional:
//   allThreadsRelatedToChannelId: The allThreadsRelatedToChannelId parameter
//     instructs the API to return all comment threads associated with the
//     specified channel. The response can include comments about the channel or
//     about the channel's videos.
//   channelId: The channelId parameter instructs the API to return comment
//     threads containing comments about the specified channel. (The response
//     will not include comments left on videos that the channel uploaded.)
//   identifier: The id parameter specifies a comma-separated list of comment
//     thread IDs for the resources that should be retrieved.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set.
//     Note: This parameter is not supported for use in conjunction with the id
//     parameter. (1..100, default 20)
//   moderationStatus: Set this parameter to limit the returned comment threads
//     to a particular moderation state.
//     Note: This parameter is not supported for use in conjunction with the id
//     parameter. (Default "MODERATION_STATUS_PUBLISHED")
//      kGTLYouTubeModerationStatusHeldForReview: Retrieve comment threads that
//        are awaiting review by a moderator. A comment thread can be included
//        in the response if the top-level comment or at least one of the
//        replies to that comment are awaiting review.
//      kGTLYouTubeModerationStatusLikelySpam: Retrieve comment threads
//        classified as likely to be spam. A comment thread can be included in
//        the response if the top-level comment or at least one of the replies
//        to that comment is considered likely to be spam.
//      kGTLYouTubeModerationStatusPublished: Retrieve threads of published
//        comments. This is the default value. A comment thread can be included
//        in the response if its top-level comment has been published.
//   order: The order parameter specifies the order in which the API response
//     should list comment threads. Valid values are:
//     - time - Comment threads are ordered by time. This is the default
//     behavior.
//     - relevance - Comment threads are ordered by relevance.Note: This
//     parameter is not supported for use in conjunction with the id parameter.
//     (Default "true")
//      kGTLYouTubeOrderRelevance: Order by relevance.
//      kGTLYouTubeOrderTime: Order by time.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken
//     property identifies the next page of the result that can be retrieved.
//     Note: This parameter is not supported for use in conjunction with the id
//     parameter.
//   searchTerms: The searchTerms parameter instructs the API to limit the API
//     response to only contain comments that contain the specified search
//     terms.
//     Note: This parameter is not supported for use in conjunction with the id
//     parameter.
//   textFormat: Set this parameter's value to html or plainText to instruct the
//     API to return the comments left by users in html formatted or in plain
//     text. (Default "FORMAT_HTML")
//      kGTLYouTubeTextFormatHtml: Returns the comments in HTML format. This is
//        the default value.
//      kGTLYouTubeTextFormatPlainText: Returns the comments in plain text
//        format.
//   videoId: The videoId parameter instructs the API to return comment threads
//     associated with the specified video ID.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeCommentThreadListResponse.
+ (instancetype)queryForCommentThreadsListWithPart:(NSString *)part;

// Method: youtube.commentThreads.update
// Modifies the top-level comment in a comment thread.
//  Required:
//   part: The part parameter specifies a comma-separated list of commentThread
//     resource properties that the API response will include. You must at least
//     include the snippet part in the parameter value since that part contains
//     all of the properties that the API request can update.
//  Authorization scope(s):
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeCommentThread.
+ (instancetype)queryForCommentThreadsUpdateWithObject:(GTLYouTubeCommentThread *)object
                                                  part:(NSString *)part;

#pragma mark - "fanFundingEvents" methods
// These create a GTLQueryYouTube object.

// Method: youtube.fanFundingEvents.list
// Lists fan funding events for a channel.
//  Required:
//   part: The part parameter specifies the fanFundingEvent resource parts that
//     the API response will include. Supported values are id and snippet.
//  Optional:
//   hl: The hl parameter instructs the API to retrieve localized resource
//     metadata for a specific application language that the YouTube website
//     supports. The parameter value must be a language code included in the
//     list returned by the i18nLanguages.list method.
//     If localized resource details are available in that language, the
//     resource's snippet.localized object will contain the localized values.
//     However, if localized details are not available, the snippet.localized
//     object will contain resource details in the resource's default language.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeFanFundingEventListResponse.
+ (instancetype)queryForFanFundingEventsListWithPart:(NSString *)part;

#pragma mark - "guideCategories" methods
// These create a GTLQueryYouTube object.

// Method: youtube.guideCategories.list
// Returns a list of categories that can be associated with YouTube channels.
//  Required:
//   part: The part parameter specifies the guideCategory resource properties
//     that the API response will include. Set the parameter value to snippet.
//  Optional:
//   hl: The hl parameter specifies the language that will be used for text
//     values in the API response. (Default en-US)
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube channel category ID(s) for the resource(s) that are being
//     retrieved. In a guideCategory resource, the id property specifies the
//     YouTube channel category ID.
//   regionCode: The regionCode parameter instructs the API to return the list
//     of guide categories available in the specified country. The parameter
//     value is an ISO 3166-1 alpha-2 country code.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeGuideCategoryListResponse.
+ (instancetype)queryForGuideCategoriesListWithPart:(NSString *)part;

#pragma mark - "i18nLanguages" methods
// These create a GTLQueryYouTube object.

// Method: youtube.i18nLanguages.list
// Returns a list of application languages that the YouTube website supports.
//  Required:
//   part: The part parameter specifies the i18nLanguage resource properties
//     that the API response will include. Set the parameter value to snippet.
//  Optional:
//   hl: The hl parameter specifies the language that should be used for text
//     values in the API response. (Default en_US)
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeI18nLanguageListResponse.
+ (instancetype)queryForI18nLanguagesListWithPart:(NSString *)part;

#pragma mark - "i18nRegions" methods
// These create a GTLQueryYouTube object.

// Method: youtube.i18nRegions.list
// Returns a list of content regions that the YouTube website supports.
//  Required:
//   part: The part parameter specifies the i18nRegion resource properties that
//     the API response will include. Set the parameter value to snippet.
//  Optional:
//   hl: The hl parameter specifies the language that should be used for text
//     values in the API response. (Default en_US)
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeI18nRegionListResponse.
+ (instancetype)queryForI18nRegionsListWithPart:(NSString *)part;

#pragma mark - "liveBroadcasts" methods
// These create a GTLQueryYouTube object.

// Method: youtube.liveBroadcasts.bind
// Binds a YouTube broadcast to a stream or removes an existing binding between
// a broadcast and a stream. A broadcast can only be bound to one video stream,
// though a video stream may be bound to more than one broadcast.
//  Required:
//   identifier: The id parameter specifies the unique ID of the broadcast that
//     is being bound to a video stream.
//   part: The part parameter specifies a comma-separated list of one or more
//     liveBroadcast resource properties that the API response will include. The
//     part names that you can include in the parameter value are id, snippet,
//     contentDetails, and status.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   streamId: The streamId parameter specifies the unique ID of the video
//     stream that is being bound to a broadcast. If this parameter is omitted,
//     the API will remove any existing binding between the broadcast and a
//     video stream.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveBroadcast.
+ (instancetype)queryForLiveBroadcastsBindWithIdentifier:(NSString *)identifier
                                                    part:(NSString *)part;

// Method: youtube.liveBroadcasts.control
// Controls the settings for a slate that can be displayed in the broadcast
// stream.
//  Required:
//   identifier: The id parameter specifies the YouTube live broadcast ID that
//     uniquely identifies the broadcast in which the slate is being updated.
//   part: The part parameter specifies a comma-separated list of one or more
//     liveBroadcast resource properties that the API response will include. The
//     part names that you can include in the parameter value are id, snippet,
//     contentDetails, and status.
//  Optional:
//   displaySlate: The displaySlate parameter specifies whether the slate is
//     being enabled or disabled.
//   offsetTimeMs: The offsetTimeMs parameter specifies a positive time offset
//     when the specified slate change will occur. The value is measured in
//     milliseconds from the beginning of the broadcast's monitor stream, which
//     is the time that the testing phase for the broadcast began. Even though
//     it is specified in milliseconds, the value is actually an approximation,
//     and YouTube completes the requested action as closely as possible to that
//     time.
//     If you do not specify a value for this parameter, then YouTube performs
//     the action as soon as possible. See the Getting started guide for more
//     details.
//     Important: You should only specify a value for this parameter if your
//     broadcast stream is delayed.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   walltime: The walltime parameter specifies the wall clock time at which the
//     specified slate change will occur. The value is specified in ISO 8601
//     (YYYY-MM-DDThh:mm:ss.sssZ) format.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveBroadcast.
+ (instancetype)queryForLiveBroadcastsControlWithIdentifier:(NSString *)identifier
                                                       part:(NSString *)part;

// Method: youtube.liveBroadcasts.delete
// Deletes a broadcast.
//  Required:
//   identifier: The id parameter specifies the YouTube live broadcast ID for
//     the resource that is being deleted.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForLiveBroadcastsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.liveBroadcasts.insert
// Creates a broadcast.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The part properties that you can include in the parameter value are id,
//     snippet, contentDetails, and status.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveBroadcast.
+ (instancetype)queryForLiveBroadcastsInsertWithObject:(GTLYouTubeLiveBroadcast *)object
                                                  part:(NSString *)part;

// Method: youtube.liveBroadcasts.list
// Returns a list of YouTube broadcasts that match the API request parameters.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     liveBroadcast resource properties that the API response will include. The
//     part names that you can include in the parameter value are id, snippet,
//     contentDetails, and status.
//  Optional:
//   broadcastStatus: The broadcastStatus parameter filters the API response to
//     only include broadcasts with the specified status.
//      kGTLYouTubeBroadcastStatusActive: Return current live broadcasts.
//      kGTLYouTubeBroadcastStatusAll: Return all broadcasts.
//      kGTLYouTubeBroadcastStatusCompleted: Return broadcasts that have already
//        ended.
//      kGTLYouTubeBroadcastStatusUpcoming: Return broadcasts that have not yet
//        started.
//   broadcastType: The broadcastType parameter filters the API response to only
//     include broadcasts with the specified type. This is only compatible with
//     the mine filter for now. (Default "BROADCAST_TYPE_FILTER_EVENT")
//      kGTLYouTubeBroadcastTypeAll: Return all broadcasts.
//      kGTLYouTubeBroadcastTypeEvent: Return only scheduled event broadcasts.
//      kGTLYouTubeBroadcastTypePersistent: Return only persistent broadcasts.
//   identifier: The id parameter specifies a comma-separated list of YouTube
//     broadcast IDs that identify the broadcasts being retrieved. In a
//     liveBroadcast resource, the id property specifies the broadcast's ID.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   mine: The mine parameter can be used to instruct the API to only return
//     broadcasts owned by the authenticated user. Set the parameter value to
//     true to only retrieve your own broadcasts.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeLiveBroadcastListResponse.
+ (instancetype)queryForLiveBroadcastsListWithPart:(NSString *)part;

// Method: youtube.liveBroadcasts.transition
// Changes the status of a YouTube live broadcast and initiates any processes
// associated with the new status. For example, when you transition a
// broadcast's status to testing, YouTube starts to transmit video to that
// broadcast's monitor stream. Before calling this method, you should confirm
// that the value of the status.streamStatus property for the stream bound to
// your broadcast is active.
//  Required:
//   broadcastStatus: The broadcastStatus parameter identifies the state to
//     which the broadcast is changing. Note that to transition a broadcast to
//     either the testing or live state, the status.streamStatus must be active
//     for the stream that the broadcast is bound to.
//      kGTLYouTubeBroadcastStatusComplete: The broadcast is over. YouTube stops
//        transmitting video.
//      kGTLYouTubeBroadcastStatusLive: The broadcast is visible to its
//        audience. YouTube transmits video to the broadcast's monitor stream
//        and its broadcast stream.
//      kGTLYouTubeBroadcastStatusTesting: Start testing the broadcast. YouTube
//        transmits video to the broadcast's monitor stream. Note that you can
//        only transition a broadcast to the testing state if its
//        contentDetails.monitorStream.enableMonitorStream property is set to
//        true.
//   identifier: The id parameter specifies the unique ID of the broadcast that
//     is transitioning to another status.
//   part: The part parameter specifies a comma-separated list of one or more
//     liveBroadcast resource properties that the API response will include. The
//     part names that you can include in the parameter value are id, snippet,
//     contentDetails, and status.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveBroadcast.
+ (instancetype)queryForLiveBroadcastsTransitionWithBroadcastStatus:(NSString *)broadcastStatus
                                                         identifier:(NSString *)identifier
                                                               part:(NSString *)part;

// Method: youtube.liveBroadcasts.update
// Updates a broadcast. For example, you could modify the broadcast settings
// defined in the liveBroadcast resource's contentDetails object.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The part properties that you can include in the parameter value are id,
//     snippet, contentDetails, and status.
//     Note that this method will override the existing values for all of the
//     mutable properties that are contained in any parts that the parameter
//     value specifies. For example, a broadcast's privacy status is defined in
//     the status part. As such, if your request is updating a private or
//     unlisted broadcast, and the request's part parameter value includes the
//     status part, the broadcast's privacy setting will be updated to whatever
//     value the request body specifies. If the request body does not specify a
//     value, the existing privacy setting will be removed and the broadcast
//     will revert to the default privacy setting.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveBroadcast.
+ (instancetype)queryForLiveBroadcastsUpdateWithObject:(GTLYouTubeLiveBroadcast *)object
                                                  part:(NSString *)part;

#pragma mark - "liveChatBans" methods
// These create a GTLQueryYouTube object.

// Method: youtube.liveChatBans.delete
// Removes a chat ban.
//  Required:
//   identifier: The id parameter identifies the chat ban to remove. The value
//     uniquely identifies both the ban and the chat.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForLiveChatBansDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.liveChatBans.insert
// Adds a new ban to the chat.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response returns. Set the parameter value to
//     snippet.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveChatBan.
+ (instancetype)queryForLiveChatBansInsertWithObject:(GTLYouTubeLiveChatBan *)object
                                                part:(NSString *)part;

#pragma mark - "liveChatMessages" methods
// These create a GTLQueryYouTube object.

// Method: youtube.liveChatMessages.delete
// Deletes a chat message.
//  Required:
//   identifier: The id parameter specifies the YouTube chat message ID of the
//     resource that is being deleted.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForLiveChatMessagesDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.liveChatMessages.insert
// Adds a message to a live chat.
//  Required:
//   part: The part parameter serves two purposes. It identifies the properties
//     that the write operation will set as well as the properties that the API
//     response will include. Set the parameter value to snippet.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveChatMessage.
+ (instancetype)queryForLiveChatMessagesInsertWithObject:(GTLYouTubeLiveChatMessage *)object
                                                    part:(NSString *)part;

// Method: youtube.liveChatMessages.list
// Lists live chat messages for a specific chat.
//  Required:
//   liveChatId: The liveChatId parameter specifies the ID of the chat whose
//     messages will be returned.
//   part: The part parameter specifies the liveChatComment resource parts that
//     the API response will include. Supported values are id and snippet.
//  Optional:
//   hl: The hl parameter instructs the API to retrieve localized resource
//     metadata for a specific application language that the YouTube website
//     supports. The parameter value must be a language code included in the
//     list returned by the i18nLanguages.list method.
//     If localized resource details are available in that language, the
//     resource's snippet.localized object will contain the localized values.
//     However, if localized details are not available, the snippet.localized
//     object will contain resource details in the resource's default language.
//   maxResults: The maxResults parameter specifies the maximum number of
//     messages that should be returned in the result set. (200..2000, default
//     500)
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken
//     property identify other pages that could be retrieved.
//   profileImageSize: The profileImageSize parameter specifies the size of the
//     user profile pictures that should be returned in the result set. Default:
//     88. (16..720)
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeLiveChatMessageListResponse.
+ (instancetype)queryForLiveChatMessagesListWithLiveChatId:(NSString *)liveChatId
                                                      part:(NSString *)part;

#pragma mark - "liveChatModerators" methods
// These create a GTLQueryYouTube object.

// Method: youtube.liveChatModerators.delete
// Removes a chat moderator.
//  Required:
//   identifier: The id parameter identifies the chat moderator to remove. The
//     value uniquely identifies both the moderator and the chat.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForLiveChatModeratorsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.liveChatModerators.insert
// Adds a new moderator for the chat.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response returns. Set the parameter value to
//     snippet.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveChatModerator.
+ (instancetype)queryForLiveChatModeratorsInsertWithObject:(GTLYouTubeLiveChatModerator *)object
                                                      part:(NSString *)part;

// Method: youtube.liveChatModerators.list
// Lists moderators for a live chat.
//  Required:
//   liveChatId: The liveChatId parameter specifies the YouTube live chat for
//     which the API should return moderators.
//   part: The part parameter specifies the liveChatModerator resource parts
//     that the API response will include. Supported values are id and snippet.
//  Optional:
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeLiveChatModeratorListResponse.
+ (instancetype)queryForLiveChatModeratorsListWithLiveChatId:(NSString *)liveChatId
                                                        part:(NSString *)part;

#pragma mark - "liveStreams" methods
// These create a GTLQueryYouTube object.

// Method: youtube.liveStreams.delete
// Deletes a video stream.
//  Required:
//   identifier: The id parameter specifies the YouTube live stream ID for the
//     resource that is being deleted.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
+ (instancetype)queryForLiveStreamsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.liveStreams.insert
// Creates a video stream. The stream enables you to send your video to YouTube,
// which can then broadcast the video to your audience.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The part properties that you can include in the parameter value are id,
//     snippet, cdn, and status.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveStream.
+ (instancetype)queryForLiveStreamsInsertWithObject:(GTLYouTubeLiveStream *)object
                                               part:(NSString *)part;

// Method: youtube.liveStreams.list
// Returns a list of video streams that match the API request parameters.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     liveStream resource properties that the API response will include. The
//     part names that you can include in the parameter value are id, snippet,
//     cdn, and status.
//  Optional:
//   identifier: The id parameter specifies a comma-separated list of YouTube
//     stream IDs that identify the streams being retrieved. In a liveStream
//     resource, the id property specifies the stream's ID.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   mine: The mine parameter can be used to instruct the API to only return
//     streams owned by the authenticated user. Set the parameter value to true
//     to only retrieve your own streams.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeLiveStreamListResponse.
+ (instancetype)queryForLiveStreamsListWithPart:(NSString *)part;

// Method: youtube.liveStreams.update
// Updates a video stream. If the properties that you want to change cannot be
// updated, then you need to create a new stream with the proper settings.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     The part properties that you can include in the parameter value are id,
//     snippet, cdn, and status.
//     Note that this method will override the existing values for all of the
//     mutable properties that are contained in any parts that the parameter
//     value specifies. If the request body does not specify a value for a
//     mutable property, the existing value for that property will be removed.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
// Fetches a GTLYouTubeLiveStream.
+ (instancetype)queryForLiveStreamsUpdateWithObject:(GTLYouTubeLiveStream *)object
                                               part:(NSString *)part;

#pragma mark - "playlistItems" methods
// These create a GTLQueryYouTube object.

// Method: youtube.playlistItems.delete
// Deletes a playlist item.
//  Required:
//   identifier: The id parameter specifies the YouTube playlist item ID for the
//     playlist item that is being deleted. In a playlistItem resource, the id
//     property specifies the playlist item's ID.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForPlaylistItemsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.playlistItems.insert
// Adds a resource to a playlist.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubePlaylistItem.
+ (instancetype)queryForPlaylistItemsInsertWithObject:(GTLYouTubePlaylistItem *)object
                                                 part:(NSString *)part;

// Method: youtube.playlistItems.list
// Returns a collection of playlist items that match the API request parameters.
// You can retrieve all of the playlist items in a specified playlist or
// retrieve one or more playlist items by their unique IDs.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     playlistItem resource properties that the API response will include.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in a
//     playlistItem resource, the snippet property contains numerous fields,
//     including the title, description, position, and resourceId properties. As
//     such, if you set part=snippet, the API response will contain all of those
//     properties.
//  Optional:
//   identifier: The id parameter specifies a comma-separated list of one or
//     more unique playlist item IDs.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//   playlistId: The playlistId parameter specifies the unique ID of the
//     playlist for which you want to retrieve playlist items. Note that even
//     though this is an optional parameter, every request to retrieve playlist
//     items must specify a value for either the id parameter or the playlistId
//     parameter.
//   videoId: The videoId parameter specifies that the request should return
//     only the playlist items that contain the specified video.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubePlaylistItemListResponse.
+ (instancetype)queryForPlaylistItemsListWithPart:(NSString *)part;

// Method: youtube.playlistItems.update
// Modifies a playlist item. For example, you could update the item's position
// in the playlist.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     Note that this method will override the existing values for all of the
//     mutable properties that are contained in any parts that the parameter
//     value specifies. For example, a playlist item can specify a start time
//     and end time, which identify the times portion of the video that should
//     play when users watch the video in the playlist. If your request is
//     updating a playlist item that sets these values, and the request's part
//     parameter value includes the contentDetails part, the playlist item's
//     start and end times will be updated to whatever value the request body
//     specifies. If the request body does not specify values, the existing
//     start and end times will be removed and replaced with the default
//     settings.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubePlaylistItem.
+ (instancetype)queryForPlaylistItemsUpdateWithObject:(GTLYouTubePlaylistItem *)object
                                                 part:(NSString *)part;

#pragma mark - "playlists" methods
// These create a GTLQueryYouTube object.

// Method: youtube.playlists.delete
// Deletes a playlist.
//  Required:
//   identifier: The id parameter specifies the YouTube playlist ID for the
//     playlist that is being deleted. In a playlist resource, the id property
//     specifies the playlist's ID.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForPlaylistsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.playlists.insert
// Creates a playlist.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubePlaylist.
+ (instancetype)queryForPlaylistsInsertWithObject:(GTLYouTubePlaylist *)object
                                             part:(NSString *)part;

// Method: youtube.playlists.list
// Returns a collection of playlists that match the API request parameters. For
// example, you can retrieve all playlists that the authenticated user owns, or
// you can retrieve one or more playlists by their unique IDs.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     playlist resource properties that the API response will include.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in a
//     playlist resource, the snippet property contains properties like author,
//     title, description, tags, and timeCreated. As such, if you set
//     part=snippet, the API response will contain all of those properties.
//  Optional:
//   channelId: This value indicates that the API should only return the
//     specified channel's playlists.
//   hl: The hl parameter should be used for filter out the properties that are
//     not in the given language. Used for the snippet part.
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube playlist ID(s) for the resource(s) that are being retrieved. In a
//     playlist resource, the id property specifies the playlist's YouTube
//     playlist ID.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   mine: Set this parameter's value to true to instruct the API to only return
//     playlists owned by the authenticated user.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubePlaylistListResponse.
+ (instancetype)queryForPlaylistsListWithPart:(NSString *)part;

// Method: youtube.playlists.update
// Modifies a playlist. For example, you could change a playlist's title,
// description, or privacy status.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     Note that this method will override the existing values for mutable
//     properties that are contained in any parts that the request body
//     specifies. For example, a playlist's description is contained in the
//     snippet part, which must be included in the request body. If the request
//     does not specify a value for the snippet.description property, the
//     playlist's existing description will be deleted.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubePlaylist.
+ (instancetype)queryForPlaylistsUpdateWithObject:(GTLYouTubePlaylist *)object
                                             part:(NSString *)part;

#pragma mark - "search" methods
// These create a GTLQueryYouTube object.

// Method: youtube.search.list
// Returns a collection of search results that match the query parameters
// specified in the API request. By default, a search result set identifies
// matching video, channel, and playlist resources, but you can also configure
// queries to only retrieve a specific type of resource.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     search resource properties that the API response will include. Set the
//     parameter value to snippet.
//  Optional:
//   channelId: The channelId parameter indicates that the API response should
//     only contain resources created by the channel
//   channelType: The channelType parameter lets you restrict a search to a
//     particular type of channel.
//      kGTLYouTubeChannelTypeAny: Return all channels.
//      kGTLYouTubeChannelTypeShow: Only retrieve shows.
//   eventType: The eventType parameter restricts a search to broadcast events.
//     If you specify a value for this parameter, you must also set the type
//     parameter's value to video.
//      kGTLYouTubeEventTypeCompleted: Only include completed broadcasts.
//      kGTLYouTubeEventTypeLive: Only include active broadcasts.
//      kGTLYouTubeEventTypeUpcoming: Only include upcoming broadcasts.
//   forContentOwner: Note: This parameter is intended exclusively for YouTube
//     content partners.
//     The forContentOwner parameter restricts the search to only retrieve
//     resources owned by the content owner specified by the
//     onBehalfOfContentOwner parameter. The user must be authenticated using a
//     CMS account linked to the specified content owner and
//     onBehalfOfContentOwner must be provided.
//   forDeveloper: The forDeveloper parameter restricts the search to only
//     retrieve videos uploaded via the developer's application or website. The
//     API server uses the request's authorization credentials to identify the
//     developer. Therefore, a developer can restrict results to videos uploaded
//     through the developer's own app or website but not to videos uploaded
//     through other apps or sites.
//   forMine: The forMine parameter restricts the search to only retrieve videos
//     owned by the authenticated user. If you set this parameter to true, then
//     the type parameter's value must also be set to video.
//   location: The location parameter, in conjunction with the locationRadius
//     parameter, defines a circular geographic area and also restricts a search
//     to videos that specify, in their metadata, a geographic location that
//     falls within that area. The parameter value is a string that specifies
//     latitude/longitude coordinates e.g. (37.42307,-122.08427).
//     - The location parameter value identifies the point at the center of the
//     area.
//     - The locationRadius parameter specifies the maximum distance that the
//     location associated with a video can be from that point for the video to
//     still be included in the search results.The API returns an error if your
//     request specifies a value for the location parameter but does not also
//     specify a value for the locationRadius parameter.
//   locationRadius: The locationRadius parameter, in conjunction with the
//     location parameter, defines a circular geographic area.
//     The parameter value must be a floating point number followed by a
//     measurement unit. Valid measurement units are m, km, ft, and mi. For
//     example, valid parameter values include 1500m, 5km, 10000ft, and 0.75mi.
//     The API does not support locationRadius parameter values larger than 1000
//     kilometers.
//     Note: See the definition of the location parameter for more information.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   order: The order parameter specifies the method that will be used to order
//     resources in the API response. (Default "SEARCH_SORT_RELEVANCE")
//      kGTLYouTubeOrderDate: Resources are sorted in reverse chronological
//        order based on the date they were created.
//      kGTLYouTubeOrderRating: Resources are sorted from highest to lowest
//        rating.
//      kGTLYouTubeOrderRelevance: Resources are sorted based on their relevance
//        to the search query. This is the default value for this parameter.
//      kGTLYouTubeOrderTitle: Resources are sorted alphabetically by title.
//      kGTLYouTubeOrderVideoCount: Channels are sorted in descending order of
//        their number of uploaded videos.
//      kGTLYouTubeOrderViewCount: Resources are sorted from highest to lowest
//        number of views.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//   publishedAfter: The publishedAfter parameter indicates that the API
//     response should only contain resources created after the specified time.
//     The value is an RFC 3339 formatted date-time value
//     (1970-01-01T00:00:00Z).
//   publishedBefore: The publishedBefore parameter indicates that the API
//     response should only contain resources created before the specified time.
//     The value is an RFC 3339 formatted date-time value
//     (1970-01-01T00:00:00Z).
//   q: The q parameter specifies the query term to search for.
//     Your request can also use the Boolean NOT (-) and OR (|) operators to
//     exclude videos or to find videos that are associated with one of several
//     search terms. For example, to search for videos matching either "boating"
//     or "sailing", set the q parameter value to boating|sailing. Similarly, to
//     search for videos matching either "boating" or "sailing" but not
//     "fishing", set the q parameter value to boating|sailing -fishing. Note
//     that the pipe character must be URL-escaped when it is sent in your API
//     request. The URL-escaped value for the pipe character is %7C.
//   regionCode: The regionCode parameter instructs the API to return search
//     results for the specified country. The parameter value is an ISO 3166-1
//     alpha-2 country code.
//   relatedToVideoId: The relatedToVideoId parameter retrieves a list of videos
//     that are related to the video that the parameter value identifies. The
//     parameter value must be set to a YouTube video ID and, if you are using
//     this parameter, the type parameter must be set to video.
//   relevanceLanguage: The relevanceLanguage parameter instructs the API to
//     return search results that are most relevant to the specified language.
//     The parameter value is typically an ISO 639-1 two-letter language code.
//     However, you should use the values zh-Hans for simplified Chinese and
//     zh-Hant for traditional Chinese. Please note that results in other
//     languages will still be returned if they are highly relevant to the
//     search query term.
//   safeSearch: The safeSearch parameter indicates whether the search results
//     should include restricted content as well as standard content.
//      kGTLYouTubeSafeSearchModerate: YouTube will filter some content from
//        search results and, at the least, will filter content that is
//        restricted in your locale. Based on their content, search results
//        could be removed from search results or demoted in search results.
//        This is the default parameter value.
//      kGTLYouTubeSafeSearchNone: YouTube will not filter the search result
//        set.
//      kGTLYouTubeSafeSearchStrict: YouTube will try to exclude all restricted
//        content from the search result set. Based on their content, search
//        results could be removed from search results or demoted in search
//        results.
//   topicId: The topicId parameter indicates that the API response should only
//     contain resources associated with the specified topic. The value
//     identifies a Freebase topic ID.
//   type: The type parameter restricts a search query to only retrieve a
//     particular type of resource. The value is a comma-separated list of
//     resource types. (Default video,channel,playlist)
//   videoCaption: The videoCaption parameter indicates whether the API should
//     filter video search results based on whether they have captions. If you
//     specify a value for this parameter, you must also set the type
//     parameter's value to video.
//      kGTLYouTubeVideoCaptionAny: Do not filter results based on caption
//        availability.
//      kGTLYouTubeVideoCaptionClosedCaption: Only include videos that have
//        captions.
//      kGTLYouTubeVideoCaptionNone: Only include videos that do not have
//        captions.
//   videoCategoryId: The videoCategoryId parameter filters video search results
//     based on their category. If you specify a value for this parameter, you
//     must also set the type parameter's value to video.
//   videoDefinition: The videoDefinition parameter lets you restrict a search
//     to only include either high definition (HD) or standard definition (SD)
//     videos. HD videos are available for playback in at least 720p, though
//     higher resolutions, like 1080p, might also be available. If you specify a
//     value for this parameter, you must also set the type parameter's value to
//     video.
//      kGTLYouTubeVideoDefinitionAny: Return all videos, regardless of their
//        resolution.
//      kGTLYouTubeVideoDefinitionHigh: Only retrieve HD videos.
//      kGTLYouTubeVideoDefinitionStandard: Only retrieve videos in standard
//        definition.
//   videoDimension: The videoDimension parameter lets you restrict a search to
//     only retrieve 2D or 3D videos. If you specify a value for this parameter,
//     you must also set the type parameter's value to video.
//      kGTLYouTubeVideoDimensionX2d: Restrict search results to exclude 3D
//        videos.
//      kGTLYouTubeVideoDimensionX3d: Restrict search results to only include 3D
//        videos.
//      kGTLYouTubeVideoDimensionAny: Include both 3D and non-3D videos in
//        returned results. This is the default value.
//   videoDuration: The videoDuration parameter filters video search results
//     based on their duration. If you specify a value for this parameter, you
//     must also set the type parameter's value to video.
//      kGTLYouTubeVideoDurationAny: Do not filter video search results based on
//        their duration. This is the default value.
//      kGTLYouTubeVideoDurationLong: Only include videos longer than 20
//        minutes.
//      kGTLYouTubeVideoDurationMedium: Only include videos that are between
//        four and 20 minutes long (inclusive).
//      kGTLYouTubeVideoDurationShort: Only include videos that are less than
//        four minutes long.
//   videoEmbeddable: The videoEmbeddable parameter lets you to restrict a
//     search to only videos that can be embedded into a webpage. If you specify
//     a value for this parameter, you must also set the type parameter's value
//     to video.
//      kGTLYouTubeVideoEmbeddableAny: Return all videos, embeddable or not.
//      kGTLYouTubeVideoEmbeddableTrue: Only retrieve embeddable videos.
//   videoLicense: The videoLicense parameter filters search results to only
//     include videos with a particular license. YouTube lets video uploaders
//     choose to attach either the Creative Commons license or the standard
//     YouTube license to each of their videos. If you specify a value for this
//     parameter, you must also set the type parameter's value to video.
//      kGTLYouTubeVideoLicenseAny: Return all videos, regardless of which
//        license they have, that match the query parameters.
//      kGTLYouTubeVideoLicenseCreativeCommon: Only return videos that have a
//        Creative Commons license. Users can reuse videos with this license in
//        other videos that they create. Learn more.
//      kGTLYouTubeVideoLicenseYoutube: Only return videos that have the
//        standard YouTube license.
//   videoSyndicated: The videoSyndicated parameter lets you to restrict a
//     search to only videos that can be played outside youtube.com. If you
//     specify a value for this parameter, you must also set the type
//     parameter's value to video.
//      kGTLYouTubeVideoSyndicatedAny: Return all videos, syndicated or not.
//      kGTLYouTubeVideoSyndicatedTrue: Only retrieve syndicated videos.
//   videoType: The videoType parameter lets you restrict a search to a
//     particular type of videos. If you specify a value for this parameter, you
//     must also set the type parameter's value to video.
//      kGTLYouTubeVideoTypeAny: Return all videos.
//      kGTLYouTubeVideoTypeEpisode: Only retrieve episodes of shows.
//      kGTLYouTubeVideoTypeMovie: Only retrieve movies.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeSearchListResponse.
+ (instancetype)queryForSearchListWithPart:(NSString *)part;

#pragma mark - "sponsors" methods
// These create a GTLQueryYouTube object.

// Method: youtube.sponsors.list
// Lists sponsors for a channel.
//  Required:
//   part: The part parameter specifies the sponsor resource parts that the API
//     response will include. Supported values are id and snippet.
//  Optional:
//   filter: The filter parameter specifies which channel sponsors to return.
//     (Default "POLL_NEWEST")
//      kGTLYouTubeFilterAll: Return all sponsors, from newest to oldest.
//      kGTLYouTubeFilterNewest: Return the most recent sponsors, from newest to
//        oldest.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeSponsorListResponse.
+ (instancetype)queryForSponsorsListWithPart:(NSString *)part;

#pragma mark - "subscriptions" methods
// These create a GTLQueryYouTube object.

// Method: youtube.subscriptions.delete
// Deletes a subscription.
//  Required:
//   identifier: The id parameter specifies the YouTube subscription ID for the
//     resource that is being deleted. In a subscription resource, the id
//     property specifies the YouTube subscription ID.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForSubscriptionsDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.subscriptions.insert
// Adds a subscription for the authenticated user's channel.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeSubscription.
+ (instancetype)queryForSubscriptionsInsertWithObject:(GTLYouTubeSubscription *)object
                                                 part:(NSString *)part;

// Method: youtube.subscriptions.list
// Returns subscription resources that match the API request criteria.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     subscription resource properties that the API response will include.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in a
//     subscription resource, the snippet property contains other properties,
//     such as a display title for the subscription. If you set part=snippet,
//     the API response will also contain all of those nested properties.
//  Optional:
//   channelId: The channelId parameter specifies a YouTube channel ID. The API
//     will only return that channel's subscriptions.
//   forChannelId: The forChannelId parameter specifies a comma-separated list
//     of channel IDs. The API response will then only contain subscriptions
//     matching those channels.
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube subscription ID(s) for the resource(s) that are being retrieved.
//     In a subscription resource, the id property specifies the YouTube
//     subscription ID.
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set. (0..50, default 5)
//   mine: Set this parameter's value to true to retrieve a feed of the
//     authenticated user's subscriptions.
//   mySubscribers: Set this parameter's value to true to retrieve a feed of the
//     subscribers of the authenticated user.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   order: The order parameter specifies the method that will be used to sort
//     resources in the API response. (Default "SUBSCRIPTION_ORDER_RELEVANCE")
//      kGTLYouTubeOrderAlphabetical: Sort alphabetically.
//      kGTLYouTubeOrderRelevance: Sort by relevance.
//      kGTLYouTubeOrderUnread: Sort by order of activity.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeSubscriptionListResponse.
+ (instancetype)queryForSubscriptionsListWithPart:(NSString *)part;

#pragma mark - "thumbnails" methods
// These create a GTLQueryYouTube object.

// Method: youtube.thumbnails.set
// Uploads a custom video thumbnail to YouTube and sets it for a video.
//  Required:
//   videoId: The videoId parameter specifies a YouTube video ID for which the
//     custom video thumbnail is being provided.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Upload Parameters:
//   Maximum size: 2MB
//   Accepted MIME type(s): application/octet-stream, image/jpeg, image/png
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeUpload
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeThumbnailSetResponse.
+ (instancetype)queryForThumbnailsSetWithVideoId:(NSString *)videoId
                                uploadParameters:(GTLUploadParameters *)uploadParametersOrNil;

#pragma mark - "videoAbuseReportReasons" methods
// These create a GTLQueryYouTube object.

// Method: youtube.videoAbuseReportReasons.list
// Returns a list of abuse reasons that can be used for reporting abusive
// videos.
//  Required:
//   part: The part parameter specifies the videoCategory resource parts that
//     the API response will include. Supported values are id and snippet.
//  Optional:
//   hl: The hl parameter specifies the language that should be used for text
//     values in the API response. (Default en_US)
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
// Fetches a GTLYouTubeVideoAbuseReportReasonListResponse.
+ (instancetype)queryForVideoAbuseReportReasonsListWithPart:(NSString *)part;

#pragma mark - "videoCategories" methods
// These create a GTLQueryYouTube object.

// Method: youtube.videoCategories.list
// Returns a list of categories that can be associated with YouTube videos.
//  Required:
//   part: The part parameter specifies the videoCategory resource properties
//     that the API response will include. Set the parameter value to snippet.
//  Optional:
//   hl: The hl parameter specifies the language that should be used for text
//     values in the API response. (Default en_US)
//   identifier: The id parameter specifies a comma-separated list of video
//     category IDs for the resources that you are retrieving.
//   regionCode: The regionCode parameter instructs the API to return the list
//     of video categories available in the specified country. The parameter
//     value is an ISO 3166-1 alpha-2 country code.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeVideoCategoryListResponse.
+ (instancetype)queryForVideoCategoriesListWithPart:(NSString *)part;

#pragma mark - "videos" methods
// These create a GTLQueryYouTube object.

// Method: youtube.videos.delete
// Deletes a YouTube video.
//  Required:
//   identifier: The id parameter specifies the YouTube video ID for the
//     resource that is being deleted. In a video resource, the id property
//     specifies the video's ID.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForVideosDeleteWithIdentifier:(NSString *)identifier;

// Method: youtube.videos.getRating
// Retrieves the ratings that the authorized user gave to a list of specified
// videos.
//  Required:
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube video ID(s) for the resource(s) for which you are retrieving
//     rating data. In a video resource, the id property specifies the video's
//     ID.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeVideoGetRatingResponse.
+ (instancetype)queryForVideosGetRatingWithIdentifier:(NSString *)identifier;

// Method: youtube.videos.insert
// Uploads a video to YouTube and optionally sets the video's metadata.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     Note that not all parts contain properties that can be set when inserting
//     or updating a video. For example, the statistics object encapsulates
//     statistics that YouTube calculates for a video and does not contain
//     values that you can set or modify. If the parameter value specifies a
//     part that does not contain mutable values, that part will still be
//     included in the API response.
//  Optional:
//   autoLevels: The autoLevels parameter indicates whether YouTube should
//     automatically enhance the video's lighting and color.
//   notifySubscribers: The notifySubscribers parameter indicates whether
//     YouTube should send a notification about the new video to users who
//     subscribe to the video's channel. A parameter value of True indicates
//     that subscribers will be notified of newly uploaded videos. However, a
//     channel owner who is uploading many videos might prefer to set the value
//     to False to avoid sending a notification about each new video to the
//     channel's subscribers. (Default true)
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   onBehalfOfContentOwnerChannel: This parameter can only be used in a
//     properly authorized request. Note: This parameter is intended exclusively
//     for YouTube content partners.
//     The onBehalfOfContentOwnerChannel parameter specifies the YouTube channel
//     ID of the channel to which a video is being added. This parameter is
//     required when a request specifies a value for the onBehalfOfContentOwner
//     parameter, and it can only be used in conjunction with that parameter. In
//     addition, the request must be authorized using a CMS account that is
//     linked to the content owner that the onBehalfOfContentOwner parameter
//     specifies. Finally, the channel that the onBehalfOfContentOwnerChannel
//     parameter value specifies must be linked to the content owner that the
//     onBehalfOfContentOwner parameter specifies.
//     This parameter is intended for YouTube content partners that own and
//     manage many different YouTube channels. It allows content owners to
//     authenticate once and perform actions on behalf of the channel specified
//     in the parameter value, without having to provide authentication
//     credentials for each separate channel.
//   stabilize: The stabilize parameter indicates whether YouTube should adjust
//     the video to remove shaky camera motions.
//  Upload Parameters:
//   Maximum size: 64GB
//   Accepted MIME type(s): application/octet-stream, video/*
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeUpload
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeVideo.
+ (instancetype)queryForVideosInsertWithObject:(GTLYouTubeVideo *)object
                                          part:(NSString *)part
                              uploadParameters:(GTLUploadParameters *)uploadParametersOrNil;

// Method: youtube.videos.list
// Returns a list of videos that match the API request parameters.
//  Required:
//   part: The part parameter specifies a comma-separated list of one or more
//     video resource properties that the API response will include.
//     If the parameter identifies a property that contains child properties,
//     the child properties will be included in the response. For example, in a
//     video resource, the snippet property contains the channelId, title,
//     description, tags, and categoryId properties. As such, if you set
//     part=snippet, the API response will contain all of those properties.
//  Optional:
//   chart: The chart parameter identifies the chart that you want to retrieve.
//      kGTLYouTubeChartMostPopular: Return the most popular videos for the
//        specified content region and video category.
//   hl: The hl parameter instructs the API to retrieve localized resource
//     metadata for a specific application language that the YouTube website
//     supports. The parameter value must be a language code included in the
//     list returned by the i18nLanguages.list method.
//     If localized resource details are available in that language, the
//     resource's snippet.localized object will contain the localized values.
//     However, if localized details are not available, the snippet.localized
//     object will contain resource details in the resource's default language.
//   identifier: The id parameter specifies a comma-separated list of the
//     YouTube video ID(s) for the resource(s) that are being retrieved. In a
//     video resource, the id property specifies the video's ID.
//   locale: DEPRECATED
//   maxResults: The maxResults parameter specifies the maximum number of items
//     that should be returned in the result set.
//     Note: This parameter is supported for use in conjunction with the
//     myRating parameter, but it is not supported for use in conjunction with
//     the id parameter. (1..50, default 5)
//   myRating: Set this parameter's value to like or dislike to instruct the API
//     to only return videos liked or disliked by the authenticated user.
//      kGTLYouTubeMyRatingDislike: Returns only videos disliked by the
//        authenticated user.
//      kGTLYouTubeMyRatingLike: Returns only video liked by the authenticated
//        user.
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//   pageToken: The pageToken parameter identifies a specific page in the result
//     set that should be returned. In an API response, the nextPageToken and
//     prevPageToken properties identify other pages that could be retrieved.
//     Note: This parameter is supported for use in conjunction with the
//     myRating parameter, but it is not supported for use in conjunction with
//     the id parameter.
//   regionCode: The regionCode parameter instructs the API to select a video
//     chart available in the specified region. This parameter can only be used
//     in conjunction with the chart parameter. The parameter value is an ISO
//     3166-1 alpha-2 country code.
//   videoCategoryId: The videoCategoryId parameter identifies the video
//     category for which the chart should be retrieved. This parameter can only
//     be used in conjunction with the chart parameter. By default, charts are
//     not restricted to a particular category. (Default 0)
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeReadonly
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeVideoListResponse.
+ (instancetype)queryForVideosListWithPart:(NSString *)part;

// Method: youtube.videos.rate
// Add a like or dislike rating to a video or remove a rating from a video.
//  Required:
//   identifier: The id parameter specifies the YouTube video ID of the video
//     that is being rated or having its rating removed.
//   rating: Specifies the rating to record.
//      kGTLYouTubeRatingDislike: Records that the authenticated user disliked
//        the video.
//      kGTLYouTubeRatingLike: Records that the authenticated user liked the
//        video.
//      kGTLYouTubeRatingNone: Removes any rating that the authenticated user
//        had previously set for the video.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForVideosRateWithIdentifier:(NSString *)identifier
                                          rating:(NSString *)rating;

// Method: youtube.videos.reportAbuse
// Report abuse for a video.
//  Optional:
//   report: GTLYouTubeVideoAbuseReport
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForVideosReportAbuse;

// Method: youtube.videos.update
// Updates a video's metadata.
//  Required:
//   part: The part parameter serves two purposes in this operation. It
//     identifies the properties that the write operation will set as well as
//     the properties that the API response will include.
//     Note that this method will override the existing values for all of the
//     mutable properties that are contained in any parts that the parameter
//     value specifies. For example, a video's privacy setting is contained in
//     the status part. As such, if your request is updating a private video,
//     and the request's part parameter value includes the status part, the
//     video's privacy setting will be updated to whatever value the request
//     body specifies. If the request body does not specify a value, the
//     existing privacy setting will be removed and the video will revert to the
//     default privacy setting.
//     In addition, not all parts contain properties that can be set when
//     inserting or updating a video. For example, the statistics object
//     encapsulates statistics that YouTube calculates for a video and does not
//     contain values that you can set or modify. If the parameter value
//     specifies a part that does not contain mutable values, that part will
//     still be included in the API response.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     actual CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
// Fetches a GTLYouTubeVideo.
+ (instancetype)queryForVideosUpdateWithObject:(GTLYouTubeVideo *)object
                                          part:(NSString *)part;

#pragma mark - "watermarks" methods
// These create a GTLQueryYouTube object.

// Method: youtube.watermarks.set
// Uploads a watermark image to YouTube and sets it for a channel.
//  Required:
//   channelId: The channelId parameter specifies the YouTube channel ID for
//     which the watermark is being provided.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Upload Parameters:
//   Maximum size: 10MB
//   Accepted MIME type(s): application/octet-stream, image/jpeg, image/png
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeUpload
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForWatermarksSetWithObject:(GTLYouTubeInvideoBranding *)object
                                      channelId:(NSString *)channelId
                               uploadParameters:(GTLUploadParameters *)uploadParametersOrNil;

// Method: youtube.watermarks.unset
// Deletes a channel's watermark image.
//  Required:
//   channelId: The channelId parameter specifies the YouTube channel ID for
//     which the watermark is being unset.
//  Optional:
//   onBehalfOfContentOwner: Note: This parameter is intended exclusively for
//     YouTube content partners.
//     The onBehalfOfContentOwner parameter indicates that the request's
//     authorization credentials identify a YouTube CMS user who is acting on
//     behalf of the content owner specified in the parameter value. This
//     parameter is intended for YouTube content partners that own and manage
//     many different YouTube channels. It allows content owners to authenticate
//     once and get access to all their video and channel data, without having
//     to provide authentication credentials for each individual channel. The
//     CMS account that the user authenticates with must be linked to the
//     specified YouTube content owner.
//  Authorization scope(s):
//   kGTLAuthScopeYouTube
//   kGTLAuthScopeYouTubeForceSsl
//   kGTLAuthScopeYouTubeYoutubepartner
+ (instancetype)queryForWatermarksUnsetWithChannelId:(NSString *)channelId;

@end

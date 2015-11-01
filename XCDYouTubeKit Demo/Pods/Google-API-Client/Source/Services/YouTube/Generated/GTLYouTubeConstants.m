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
//  GTLYouTubeConstants.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Programmatic access to YouTube features.
// Documentation:
//   https://developers.google.com/youtube/v3

#import "GTLYouTubeConstants.h"

// Authorization scope
NSString * const kGTLAuthScopeYouTube                          = @"https://www.googleapis.com/auth/youtube";
NSString * const kGTLAuthScopeYouTubeReadonly                  = @"https://www.googleapis.com/auth/youtube.readonly";
NSString * const kGTLAuthScopeYouTubeUpload                    = @"https://www.googleapis.com/auth/youtube.upload";
NSString * const kGTLAuthScopeYouTubeYoutubepartner            = @"https://www.googleapis.com/auth/youtubepartner";
NSString * const kGTLAuthScopeYouTubeYoutubepartnerChannelAudit = @"https://www.googleapis.com/auth/youtubepartner-channel-audit";

// GTLQueryYouTube - BroadcastStatus
NSString * const kGTLYouTubeBroadcastStatusActive    = @"active";
NSString * const kGTLYouTubeBroadcastStatusAll       = @"all";
NSString * const kGTLYouTubeBroadcastStatusComplete  = @"complete";
NSString * const kGTLYouTubeBroadcastStatusCompleted = @"completed";
NSString * const kGTLYouTubeBroadcastStatusLive      = @"live";
NSString * const kGTLYouTubeBroadcastStatusTesting   = @"testing";
NSString * const kGTLYouTubeBroadcastStatusUpcoming  = @"upcoming";

// GTLQueryYouTube - ChannelType
NSString * const kGTLYouTubeChannelTypeAny  = @"any";
NSString * const kGTLYouTubeChannelTypeShow = @"show";

// GTLQueryYouTube - Chart
NSString * const kGTLYouTubeChartMostPopular = @"mostPopular";

// GTLQueryYouTube - EventType
NSString * const kGTLYouTubeEventTypeCompleted = @"completed";
NSString * const kGTLYouTubeEventTypeLive      = @"live";
NSString * const kGTLYouTubeEventTypeUpcoming  = @"upcoming";

// GTLQueryYouTube - MyRating
NSString * const kGTLYouTubeMyRatingDislike = @"dislike";
NSString * const kGTLYouTubeMyRatingLike    = @"like";

// GTLQueryYouTube - Order
NSString * const kGTLYouTubeOrderAlphabetical = @"alphabetical";
NSString * const kGTLYouTubeOrderDate         = @"date";
NSString * const kGTLYouTubeOrderRating       = @"rating";
NSString * const kGTLYouTubeOrderRelevance    = @"relevance";
NSString * const kGTLYouTubeOrderTitle        = @"title";
NSString * const kGTLYouTubeOrderUnread       = @"unread";
NSString * const kGTLYouTubeOrderVideoCount   = @"videoCount";
NSString * const kGTLYouTubeOrderViewCount    = @"viewCount";

// GTLQueryYouTube - Rating
NSString * const kGTLYouTubeRatingDislike = @"dislike";
NSString * const kGTLYouTubeRatingLike    = @"like";
NSString * const kGTLYouTubeRatingNone    = @"none";

// GTLQueryYouTube - SafeSearch
NSString * const kGTLYouTubeSafeSearchModerate = @"moderate";
NSString * const kGTLYouTubeSafeSearchNone     = @"none";
NSString * const kGTLYouTubeSafeSearchStrict   = @"strict";

// GTLQueryYouTube - VideoCaption
NSString * const kGTLYouTubeVideoCaptionAny           = @"any";
NSString * const kGTLYouTubeVideoCaptionClosedCaption = @"closedCaption";
NSString * const kGTLYouTubeVideoCaptionNone          = @"none";

// GTLQueryYouTube - VideoDefinition
NSString * const kGTLYouTubeVideoDefinitionAny      = @"any";
NSString * const kGTLYouTubeVideoDefinitionHigh     = @"high";
NSString * const kGTLYouTubeVideoDefinitionStandard = @"standard";

// GTLQueryYouTube - VideoDimension
NSString * const kGTLYouTubeVideoDimensionAny = @"any";
NSString * const kGTLYouTubeVideoDimensionX2d = @"2d";
NSString * const kGTLYouTubeVideoDimensionX3d = @"3d";

// GTLQueryYouTube - VideoDuration
NSString * const kGTLYouTubeVideoDurationAny    = @"any";
NSString * const kGTLYouTubeVideoDurationLong   = @"long";
NSString * const kGTLYouTubeVideoDurationMedium = @"medium";
NSString * const kGTLYouTubeVideoDurationShort  = @"short";

// GTLQueryYouTube - VideoEmbeddable
NSString * const kGTLYouTubeVideoEmbeddableAny  = @"any";
NSString * const kGTLYouTubeVideoEmbeddableTrue = @"true";

// GTLQueryYouTube - VideoLicense
NSString * const kGTLYouTubeVideoLicenseAny            = @"any";
NSString * const kGTLYouTubeVideoLicenseCreativeCommon = @"creativeCommon";
NSString * const kGTLYouTubeVideoLicenseYoutube        = @"youtube";

// GTLQueryYouTube - VideoSyndicated
NSString * const kGTLYouTubeVideoSyndicatedAny  = @"any";
NSString * const kGTLYouTubeVideoSyndicatedTrue = @"true";

// GTLQueryYouTube - VideoType
NSString * const kGTLYouTubeVideoTypeAny     = @"any";
NSString * const kGTLYouTubeVideoTypeEpisode = @"episode";
NSString * const kGTLYouTubeVideoTypeMovie   = @"movie";

// GTLYouTubeActivityContentDetailsPromotedItem - CtaType
NSString * const kGTLYouTubeActivityContentDetailsPromotedItem_CtaType_Unspecified = @"unspecified";
NSString * const kGTLYouTubeActivityContentDetailsPromotedItem_CtaType_VisitAdvertiserSite = @"visitAdvertiserSite";

// GTLYouTubeActivityContentDetailsRecommendation - Reason
NSString * const kGTLYouTubeActivityContentDetailsRecommendation_Reason_Unspecified = @"unspecified";
NSString * const kGTLYouTubeActivityContentDetailsRecommendation_Reason_VideoFavorited = @"videoFavorited";
NSString * const kGTLYouTubeActivityContentDetailsRecommendation_Reason_VideoLiked = @"videoLiked";
NSString * const kGTLYouTubeActivityContentDetailsRecommendation_Reason_VideoWatched = @"videoWatched";

// GTLYouTubeActivityContentDetailsSocial - Type
NSString * const kGTLYouTubeActivityContentDetailsSocial_Type_Facebook = @"facebook";
NSString * const kGTLYouTubeActivityContentDetailsSocial_Type_GooglePlus = @"googlePlus";
NSString * const kGTLYouTubeActivityContentDetailsSocial_Type_Twitter = @"twitter";
NSString * const kGTLYouTubeActivityContentDetailsSocial_Type_Unspecified = @"unspecified";

// GTLYouTubeActivitySnippet - Type
NSString * const kGTLYouTubeActivitySnippet_Type_Bulletin      = @"bulletin";
NSString * const kGTLYouTubeActivitySnippet_Type_ChannelItem   = @"channelItem";
NSString * const kGTLYouTubeActivitySnippet_Type_Comment       = @"comment";
NSString * const kGTLYouTubeActivitySnippet_Type_Favorite      = @"favorite";
NSString * const kGTLYouTubeActivitySnippet_Type_Like          = @"like";
NSString * const kGTLYouTubeActivitySnippet_Type_PlaylistItem  = @"playlistItem";
NSString * const kGTLYouTubeActivitySnippet_Type_PromotedItem  = @"promotedItem";
NSString * const kGTLYouTubeActivitySnippet_Type_Recommendation = @"recommendation";
NSString * const kGTLYouTubeActivitySnippet_Type_Social        = @"social";
NSString * const kGTLYouTubeActivitySnippet_Type_Subscription  = @"subscription";
NSString * const kGTLYouTubeActivitySnippet_Type_Upload        = @"upload";

// GTLYouTubeCdnSettings - IngestionType
NSString * const kGTLYouTubeCdnSettings_IngestionType_Dash = @"dash";
NSString * const kGTLYouTubeCdnSettings_IngestionType_Rtmp = @"rtmp";

// GTLYouTubeChannelConversionPing - Context
NSString * const kGTLYouTubeChannelConversionPing_Context_Cview = @"cview";
NSString * const kGTLYouTubeChannelConversionPing_Context_Subscribe = @"subscribe";
NSString * const kGTLYouTubeChannelConversionPing_Context_Unsubscribe = @"unsubscribe";

// GTLYouTubeChannelSectionSnippet - Style
NSString * const kGTLYouTubeChannelSectionSnippet_Style_ChannelsectionStyleUndefined = @"channelsectionStyleUndefined";
NSString * const kGTLYouTubeChannelSectionSnippet_Style_HorizontalRow = @"horizontalRow";
NSString * const kGTLYouTubeChannelSectionSnippet_Style_VerticalList = @"verticalList";

// GTLYouTubeChannelSectionSnippet - Type
NSString * const kGTLYouTubeChannelSectionSnippet_Type_AllPlaylists = @"allPlaylists";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_ChannelsectionTypeUndefined = @"channelsectionTypeUndefined";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_CompletedEvents = @"completedEvents";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_LikedPlaylists = @"likedPlaylists";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_Likes   = @"likes";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_LiveEvents = @"liveEvents";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_MultipleChannels = @"multipleChannels";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_MultiplePlaylists = @"multiplePlaylists";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_PopularUploads = @"popularUploads";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_PostedPlaylists = @"postedPlaylists";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_PostedVideos = @"postedVideos";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_RecentActivity = @"recentActivity";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_RecentPosts = @"recentPosts";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_RecentUploads = @"recentUploads";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_SinglePlaylist = @"singlePlaylist";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_Subscriptions = @"subscriptions";
NSString * const kGTLYouTubeChannelSectionSnippet_Type_UpcomingEvents = @"upcomingEvents";

// GTLYouTubeChannelStatus - LongUploadsStatus
NSString * const kGTLYouTubeChannelStatus_LongUploadsStatus_Allowed = @"allowed";
NSString * const kGTLYouTubeChannelStatus_LongUploadsStatus_Disallowed = @"disallowed";
NSString * const kGTLYouTubeChannelStatus_LongUploadsStatus_Eligible = @"eligible";
NSString * const kGTLYouTubeChannelStatus_LongUploadsStatus_LongUploadsUnspecified = @"longUploadsUnspecified";

// GTLYouTubeChannelStatus - PrivacyStatus
NSString * const kGTLYouTubeChannelStatus_PrivacyStatus_Private = @"private";
NSString * const kGTLYouTubeChannelStatus_PrivacyStatus_Public = @"public";
NSString * const kGTLYouTubeChannelStatus_PrivacyStatus_Unlisted = @"unlisted";

// GTLYouTubeContentRating - AcbRating
NSString * const kGTLYouTubeContentRating_AcbRating_AcbC       = @"acbC";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbE       = @"acbE";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbG       = @"acbG";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbM       = @"acbM";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbMa15plus = @"acbMa15plus";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbP       = @"acbP";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbPg      = @"acbPg";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbR18plus = @"acbR18plus";
NSString * const kGTLYouTubeContentRating_AcbRating_AcbUnrated = @"acbUnrated";

// GTLYouTubeContentRating - AgcomRating
NSString * const kGTLYouTubeContentRating_AgcomRating_AgcomT   = @"agcomT";
NSString * const kGTLYouTubeContentRating_AgcomRating_AgcomUnrated = @"agcomUnrated";
NSString * const kGTLYouTubeContentRating_AgcomRating_AgcomVm14 = @"agcomVm14";
NSString * const kGTLYouTubeContentRating_AgcomRating_AgcomVm18 = @"agcomVm18";

// GTLYouTubeContentRating - AnatelRating
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelA = @"anatelA";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelF = @"anatelF";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelI = @"anatelI";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelI10 = @"anatelI10";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelI12 = @"anatelI12";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelI7 = @"anatelI7";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelR = @"anatelR";
NSString * const kGTLYouTubeContentRating_AnatelRating_AnatelUnrated = @"anatelUnrated";

// GTLYouTubeContentRating - BbfcRating
NSString * const kGTLYouTubeContentRating_BbfcRating_Bbfc12    = @"bbfc12";
NSString * const kGTLYouTubeContentRating_BbfcRating_Bbfc12a   = @"bbfc12a";
NSString * const kGTLYouTubeContentRating_BbfcRating_Bbfc15    = @"bbfc15";
NSString * const kGTLYouTubeContentRating_BbfcRating_Bbfc18    = @"bbfc18";
NSString * const kGTLYouTubeContentRating_BbfcRating_BbfcPg    = @"bbfcPg";
NSString * const kGTLYouTubeContentRating_BbfcRating_BbfcR18   = @"bbfcR18";
NSString * const kGTLYouTubeContentRating_BbfcRating_BbfcU     = @"bbfcU";
NSString * const kGTLYouTubeContentRating_BbfcRating_BbfcUnrated = @"bbfcUnrated";

// GTLYouTubeContentRating - BfvcRating
NSString * const kGTLYouTubeContentRating_BfvcRating_Bfvc13    = @"bfvc13";
NSString * const kGTLYouTubeContentRating_BfvcRating_Bfvc15    = @"bfvc15";
NSString * const kGTLYouTubeContentRating_BfvcRating_Bfvc18    = @"bfvc18";
NSString * const kGTLYouTubeContentRating_BfvcRating_Bfvc20    = @"bfvc20";
NSString * const kGTLYouTubeContentRating_BfvcRating_BfvcB     = @"bfvcB";
NSString * const kGTLYouTubeContentRating_BfvcRating_BfvcE     = @"bfvcE";
NSString * const kGTLYouTubeContentRating_BfvcRating_BfvcG     = @"bfvcG";
NSString * const kGTLYouTubeContentRating_BfvcRating_BfvcUnrated = @"bfvcUnrated";

// GTLYouTubeContentRating - BmukkRating
NSString * const kGTLYouTubeContentRating_BmukkRating_Bmukk10  = @"bmukk10";
NSString * const kGTLYouTubeContentRating_BmukkRating_Bmukk12  = @"bmukk12";
NSString * const kGTLYouTubeContentRating_BmukkRating_Bmukk14  = @"bmukk14";
NSString * const kGTLYouTubeContentRating_BmukkRating_Bmukk16  = @"bmukk16";
NSString * const kGTLYouTubeContentRating_BmukkRating_Bmukk6   = @"bmukk6";
NSString * const kGTLYouTubeContentRating_BmukkRating_Bmukk8   = @"bmukk8";
NSString * const kGTLYouTubeContentRating_BmukkRating_BmukkAa  = @"bmukkAa";
NSString * const kGTLYouTubeContentRating_BmukkRating_BmukkUnrated = @"bmukkUnrated";

// GTLYouTubeContentRating - CatvfrRating
NSString * const kGTLYouTubeContentRating_CatvfrRating_Catvfr13plus = @"catvfr13plus";
NSString * const kGTLYouTubeContentRating_CatvfrRating_Catvfr16plus = @"catvfr16plus";
NSString * const kGTLYouTubeContentRating_CatvfrRating_Catvfr18plus = @"catvfr18plus";
NSString * const kGTLYouTubeContentRating_CatvfrRating_Catvfr8plus = @"catvfr8plus";
NSString * const kGTLYouTubeContentRating_CatvfrRating_CatvfrG = @"catvfrG";
NSString * const kGTLYouTubeContentRating_CatvfrRating_CatvfrUnrated = @"catvfrUnrated";

// GTLYouTubeContentRating - CatvRating
NSString * const kGTLYouTubeContentRating_CatvRating_Catv14plus = @"catv14plus";
NSString * const kGTLYouTubeContentRating_CatvRating_Catv18plus = @"catv18plus";
NSString * const kGTLYouTubeContentRating_CatvRating_CatvC     = @"catvC";
NSString * const kGTLYouTubeContentRating_CatvRating_CatvC8    = @"catvC8";
NSString * const kGTLYouTubeContentRating_CatvRating_CatvG     = @"catvG";
NSString * const kGTLYouTubeContentRating_CatvRating_CatvPg    = @"catvPg";
NSString * const kGTLYouTubeContentRating_CatvRating_CatvUnrated = @"catvUnrated";

// GTLYouTubeContentRating - CbfcRating
NSString * const kGTLYouTubeContentRating_CbfcRating_CbfcA     = @"cbfcA";
NSString * const kGTLYouTubeContentRating_CbfcRating_CbfcS     = @"cbfcS";
NSString * const kGTLYouTubeContentRating_CbfcRating_CbfcU     = @"cbfcU";
NSString * const kGTLYouTubeContentRating_CbfcRating_CbfcUA    = @"cbfcUA";
NSString * const kGTLYouTubeContentRating_CbfcRating_CbfcUnrated = @"cbfcUnrated";

// GTLYouTubeContentRating - CccRating
NSString * const kGTLYouTubeContentRating_CccRating_Ccc14      = @"ccc14";
NSString * const kGTLYouTubeContentRating_CccRating_Ccc18      = @"ccc18";
NSString * const kGTLYouTubeContentRating_CccRating_Ccc18s     = @"ccc18s";
NSString * const kGTLYouTubeContentRating_CccRating_Ccc18v     = @"ccc18v";
NSString * const kGTLYouTubeContentRating_CccRating_Ccc6       = @"ccc6";
NSString * const kGTLYouTubeContentRating_CccRating_CccTe      = @"cccTe";
NSString * const kGTLYouTubeContentRating_CccRating_CccUnrated = @"cccUnrated";

// GTLYouTubeContentRating - CceRating
NSString * const kGTLYouTubeContentRating_CceRating_CceM12     = @"cceM12";
NSString * const kGTLYouTubeContentRating_CceRating_CceM16     = @"cceM16";
NSString * const kGTLYouTubeContentRating_CceRating_CceM18     = @"cceM18";
NSString * const kGTLYouTubeContentRating_CceRating_CceM4      = @"cceM4";
NSString * const kGTLYouTubeContentRating_CceRating_CceM6      = @"cceM6";
NSString * const kGTLYouTubeContentRating_CceRating_CceUnrated = @"cceUnrated";

// GTLYouTubeContentRating - ChfilmRating
NSString * const kGTLYouTubeContentRating_ChfilmRating_Chfilm0 = @"chfilm0";
NSString * const kGTLYouTubeContentRating_ChfilmRating_Chfilm12 = @"chfilm12";
NSString * const kGTLYouTubeContentRating_ChfilmRating_Chfilm16 = @"chfilm16";
NSString * const kGTLYouTubeContentRating_ChfilmRating_Chfilm18 = @"chfilm18";
NSString * const kGTLYouTubeContentRating_ChfilmRating_Chfilm6 = @"chfilm6";
NSString * const kGTLYouTubeContentRating_ChfilmRating_ChfilmUnrated = @"chfilmUnrated";

// GTLYouTubeContentRating - ChvrsRating
NSString * const kGTLYouTubeContentRating_ChvrsRating_Chvrs14a = @"chvrs14a";
NSString * const kGTLYouTubeContentRating_ChvrsRating_Chvrs18a = @"chvrs18a";
NSString * const kGTLYouTubeContentRating_ChvrsRating_ChvrsE   = @"chvrsE";
NSString * const kGTLYouTubeContentRating_ChvrsRating_ChvrsG   = @"chvrsG";
NSString * const kGTLYouTubeContentRating_ChvrsRating_ChvrsPg  = @"chvrsPg";
NSString * const kGTLYouTubeContentRating_ChvrsRating_ChvrsR   = @"chvrsR";
NSString * const kGTLYouTubeContentRating_ChvrsRating_ChvrsUnrated = @"chvrsUnrated";

// GTLYouTubeContentRating - CicfRating
NSString * const kGTLYouTubeContentRating_CicfRating_CicfE     = @"cicfE";
NSString * const kGTLYouTubeContentRating_CicfRating_CicfKntEna = @"cicfKntEna";
NSString * const kGTLYouTubeContentRating_CicfRating_CicfKtEa  = @"cicfKtEa";
NSString * const kGTLYouTubeContentRating_CicfRating_CicfUnrated = @"cicfUnrated";

// GTLYouTubeContentRating - CnaRating
NSString * const kGTLYouTubeContentRating_CnaRating_Cna12      = @"cna12";
NSString * const kGTLYouTubeContentRating_CnaRating_Cna15      = @"cna15";
NSString * const kGTLYouTubeContentRating_CnaRating_Cna18      = @"cna18";
NSString * const kGTLYouTubeContentRating_CnaRating_Cna18plus  = @"cna18plus";
NSString * const kGTLYouTubeContentRating_CnaRating_CnaAp      = @"cnaAp";
NSString * const kGTLYouTubeContentRating_CnaRating_CnaUnrated = @"cnaUnrated";

// GTLYouTubeContentRating - CsaRating
NSString * const kGTLYouTubeContentRating_CsaRating_Csa10      = @"csa10";
NSString * const kGTLYouTubeContentRating_CsaRating_Csa12      = @"csa12";
NSString * const kGTLYouTubeContentRating_CsaRating_Csa16      = @"csa16";
NSString * const kGTLYouTubeContentRating_CsaRating_Csa18      = @"csa18";
NSString * const kGTLYouTubeContentRating_CsaRating_CsaInterdiction = @"csaInterdiction";
NSString * const kGTLYouTubeContentRating_CsaRating_CsaUnrated = @"csaUnrated";

// GTLYouTubeContentRating - CscfRating
NSString * const kGTLYouTubeContentRating_CscfRating_Cscf12    = @"cscf12";
NSString * const kGTLYouTubeContentRating_CscfRating_Cscf16    = @"cscf16";
NSString * const kGTLYouTubeContentRating_CscfRating_Cscf18    = @"cscf18";
NSString * const kGTLYouTubeContentRating_CscfRating_Cscf6     = @"cscf6";
NSString * const kGTLYouTubeContentRating_CscfRating_CscfA     = @"cscfA";
NSString * const kGTLYouTubeContentRating_CscfRating_CscfUnrated = @"cscfUnrated";

// GTLYouTubeContentRating - CzfilmRating
NSString * const kGTLYouTubeContentRating_CzfilmRating_Czfilm12 = @"czfilm12";
NSString * const kGTLYouTubeContentRating_CzfilmRating_Czfilm14 = @"czfilm14";
NSString * const kGTLYouTubeContentRating_CzfilmRating_Czfilm18 = @"czfilm18";
NSString * const kGTLYouTubeContentRating_CzfilmRating_CzfilmU = @"czfilmU";
NSString * const kGTLYouTubeContentRating_CzfilmRating_CzfilmUnrated = @"czfilmUnrated";

// GTLYouTubeContentRating - DjctqRating
NSString * const kGTLYouTubeContentRating_DjctqRating_Djctq10  = @"djctq10";
NSString * const kGTLYouTubeContentRating_DjctqRating_Djctq12  = @"djctq12";
NSString * const kGTLYouTubeContentRating_DjctqRating_Djctq14  = @"djctq14";
NSString * const kGTLYouTubeContentRating_DjctqRating_Djctq16  = @"djctq16";
NSString * const kGTLYouTubeContentRating_DjctqRating_Djctq18  = @"djctq18";
NSString * const kGTLYouTubeContentRating_DjctqRating_DjctqL   = @"djctqL";
NSString * const kGTLYouTubeContentRating_DjctqRating_DjctqUnrated = @"djctqUnrated";

// GTLYouTubeContentRating - DjctqRatingReasons
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqCriminalActs = @"djctqCriminalActs";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqDrugs = @"djctqDrugs";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqExplicitSex = @"djctqExplicitSex";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqExtremeViolence = @"djctqExtremeViolence";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqIllegalDrugs = @"djctqIllegalDrugs";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqImpactingContent = @"djctqImpactingContent";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqInappropriateLanguage = @"djctqInappropriateLanguage";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqLegalDrugs = @"djctqLegalDrugs";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqNudity = @"djctqNudity";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqSex = @"djctqSex";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqSexualContent = @"djctqSexualContent";
NSString * const kGTLYouTubeContentRating_DjctqRatingReasons_DjctqViolence = @"djctqViolence";

// GTLYouTubeContentRating - EefilmRating
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmK12 = @"eefilmK12";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmK14 = @"eefilmK14";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmK16 = @"eefilmK16";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmK6 = @"eefilmK6";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmL = @"eefilmL";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmMs12 = @"eefilmMs12";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmMs6 = @"eefilmMs6";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmPere = @"eefilmPere";
NSString * const kGTLYouTubeContentRating_EefilmRating_EefilmUnrated = @"eefilmUnrated";

// GTLYouTubeContentRating - EgfilmRating
NSString * const kGTLYouTubeContentRating_EgfilmRating_Egfilm18 = @"egfilm18";
NSString * const kGTLYouTubeContentRating_EgfilmRating_EgfilmBn = @"egfilmBn";
NSString * const kGTLYouTubeContentRating_EgfilmRating_EgfilmGn = @"egfilmGn";
NSString * const kGTLYouTubeContentRating_EgfilmRating_EgfilmUnrated = @"egfilmUnrated";

// GTLYouTubeContentRating - EirinRating
NSString * const kGTLYouTubeContentRating_EirinRating_EirinG   = @"eirinG";
NSString * const kGTLYouTubeContentRating_EirinRating_EirinPg12 = @"eirinPg12";
NSString * const kGTLYouTubeContentRating_EirinRating_EirinR15plus = @"eirinR15plus";
NSString * const kGTLYouTubeContentRating_EirinRating_EirinR18plus = @"eirinR18plus";
NSString * const kGTLYouTubeContentRating_EirinRating_EirinUnrated = @"eirinUnrated";

// GTLYouTubeContentRating - FcbmRating
NSString * const kGTLYouTubeContentRating_FcbmRating_Fcbm18    = @"fcbm18";
NSString * const kGTLYouTubeContentRating_FcbmRating_Fcbm18pa  = @"fcbm18pa";
NSString * const kGTLYouTubeContentRating_FcbmRating_Fcbm18pl  = @"fcbm18pl";
NSString * const kGTLYouTubeContentRating_FcbmRating_Fcbm18sg  = @"fcbm18sg";
NSString * const kGTLYouTubeContentRating_FcbmRating_Fcbm18sx  = @"fcbm18sx";
NSString * const kGTLYouTubeContentRating_FcbmRating_FcbmP13   = @"fcbmP13";
NSString * const kGTLYouTubeContentRating_FcbmRating_FcbmU     = @"fcbmU";
NSString * const kGTLYouTubeContentRating_FcbmRating_FcbmUnrated = @"fcbmUnrated";

// GTLYouTubeContentRating - FcoRating
NSString * const kGTLYouTubeContentRating_FcoRating_FcoI       = @"fcoI";
NSString * const kGTLYouTubeContentRating_FcoRating_FcoIia     = @"fcoIia";
NSString * const kGTLYouTubeContentRating_FcoRating_FcoIib     = @"fcoIib";
NSString * const kGTLYouTubeContentRating_FcoRating_FcoIii     = @"fcoIii";
NSString * const kGTLYouTubeContentRating_FcoRating_FcoUnrated = @"fcoUnrated";

// GTLYouTubeContentRating - FmocRating
NSString * const kGTLYouTubeContentRating_FmocRating_Fmoc10    = @"fmoc10";
NSString * const kGTLYouTubeContentRating_FmocRating_Fmoc12    = @"fmoc12";
NSString * const kGTLYouTubeContentRating_FmocRating_Fmoc16    = @"fmoc16";
NSString * const kGTLYouTubeContentRating_FmocRating_Fmoc18    = @"fmoc18";
NSString * const kGTLYouTubeContentRating_FmocRating_FmocE     = @"fmocE";
NSString * const kGTLYouTubeContentRating_FmocRating_FmocU     = @"fmocU";
NSString * const kGTLYouTubeContentRating_FmocRating_FmocUnrated = @"fmocUnrated";

// GTLYouTubeContentRating - FpbRating
NSString * const kGTLYouTubeContentRating_FpbRating_Fpb1012Pg  = @"fpb1012Pg";
NSString * const kGTLYouTubeContentRating_FpbRating_Fpb13      = @"fpb13";
NSString * const kGTLYouTubeContentRating_FpbRating_Fpb16      = @"fpb16";
NSString * const kGTLYouTubeContentRating_FpbRating_Fpb18      = @"fpb18";
NSString * const kGTLYouTubeContentRating_FpbRating_Fpb79Pg    = @"fpb79Pg";
NSString * const kGTLYouTubeContentRating_FpbRating_FpbA       = @"fpbA";
NSString * const kGTLYouTubeContentRating_FpbRating_FpbPg      = @"fpbPg";
NSString * const kGTLYouTubeContentRating_FpbRating_FpbUnrated = @"fpbUnrated";
NSString * const kGTLYouTubeContentRating_FpbRating_FpbX18     = @"fpbX18";
NSString * const kGTLYouTubeContentRating_FpbRating_FpbXx      = @"fpbXx";

// GTLYouTubeContentRating - FskRating
NSString * const kGTLYouTubeContentRating_FskRating_Fsk0       = @"fsk0";
NSString * const kGTLYouTubeContentRating_FskRating_Fsk12      = @"fsk12";
NSString * const kGTLYouTubeContentRating_FskRating_Fsk16      = @"fsk16";
NSString * const kGTLYouTubeContentRating_FskRating_Fsk18      = @"fsk18";
NSString * const kGTLYouTubeContentRating_FskRating_Fsk6       = @"fsk6";
NSString * const kGTLYouTubeContentRating_FskRating_FskUnrated = @"fskUnrated";

// GTLYouTubeContentRating - GrfilmRating
NSString * const kGTLYouTubeContentRating_GrfilmRating_GrfilmE = @"grfilmE";
NSString * const kGTLYouTubeContentRating_GrfilmRating_GrfilmK = @"grfilmK";
NSString * const kGTLYouTubeContentRating_GrfilmRating_GrfilmK13 = @"grfilmK13";
NSString * const kGTLYouTubeContentRating_GrfilmRating_GrfilmK17 = @"grfilmK17";
NSString * const kGTLYouTubeContentRating_GrfilmRating_GrfilmUnrated = @"grfilmUnrated";

// GTLYouTubeContentRating - IcaaRating
NSString * const kGTLYouTubeContentRating_IcaaRating_Icaa12    = @"icaa12";
NSString * const kGTLYouTubeContentRating_IcaaRating_Icaa13    = @"icaa13";
NSString * const kGTLYouTubeContentRating_IcaaRating_Icaa16    = @"icaa16";
NSString * const kGTLYouTubeContentRating_IcaaRating_Icaa18    = @"icaa18";
NSString * const kGTLYouTubeContentRating_IcaaRating_Icaa7     = @"icaa7";
NSString * const kGTLYouTubeContentRating_IcaaRating_IcaaApta  = @"icaaApta";
NSString * const kGTLYouTubeContentRating_IcaaRating_IcaaUnrated = @"icaaUnrated";
NSString * const kGTLYouTubeContentRating_IcaaRating_IcaaX     = @"icaaX";

// GTLYouTubeContentRating - IfcoRating
NSString * const kGTLYouTubeContentRating_IfcoRating_Ifco12    = @"ifco12";
NSString * const kGTLYouTubeContentRating_IfcoRating_Ifco15    = @"ifco15";
NSString * const kGTLYouTubeContentRating_IfcoRating_Ifco18    = @"ifco18";
NSString * const kGTLYouTubeContentRating_IfcoRating_IfcoG     = @"ifcoG";
NSString * const kGTLYouTubeContentRating_IfcoRating_IfcoPg    = @"ifcoPg";
NSString * const kGTLYouTubeContentRating_IfcoRating_IfcoUnrated = @"ifcoUnrated";

// GTLYouTubeContentRating - IlfilmRating
NSString * const kGTLYouTubeContentRating_IlfilmRating_Ilfilm12 = @"ilfilm12";
NSString * const kGTLYouTubeContentRating_IlfilmRating_Ilfilm16 = @"ilfilm16";
NSString * const kGTLYouTubeContentRating_IlfilmRating_Ilfilm18 = @"ilfilm18";
NSString * const kGTLYouTubeContentRating_IlfilmRating_IlfilmAa = @"ilfilmAa";
NSString * const kGTLYouTubeContentRating_IlfilmRating_IlfilmUnrated = @"ilfilmUnrated";

// GTLYouTubeContentRating - IncaaRating
NSString * const kGTLYouTubeContentRating_IncaaRating_IncaaAtp = @"incaaAtp";
NSString * const kGTLYouTubeContentRating_IncaaRating_IncaaC   = @"incaaC";
NSString * const kGTLYouTubeContentRating_IncaaRating_IncaaSam13 = @"incaaSam13";
NSString * const kGTLYouTubeContentRating_IncaaRating_IncaaSam16 = @"incaaSam16";
NSString * const kGTLYouTubeContentRating_IncaaRating_IncaaSam18 = @"incaaSam18";
NSString * const kGTLYouTubeContentRating_IncaaRating_IncaaUnrated = @"incaaUnrated";

// GTLYouTubeContentRating - KfcbRating
NSString * const kGTLYouTubeContentRating_KfcbRating_Kfcb16plus = @"kfcb16plus";
NSString * const kGTLYouTubeContentRating_KfcbRating_KfcbG     = @"kfcbG";
NSString * const kGTLYouTubeContentRating_KfcbRating_KfcbPg    = @"kfcbPg";
NSString * const kGTLYouTubeContentRating_KfcbRating_KfcbR     = @"kfcbR";
NSString * const kGTLYouTubeContentRating_KfcbRating_KfcbUnrated = @"kfcbUnrated";

// GTLYouTubeContentRating - KijkwijzerRating
NSString * const kGTLYouTubeContentRating_KijkwijzerRating_Kijkwijzer12 = @"kijkwijzer12";
NSString * const kGTLYouTubeContentRating_KijkwijzerRating_Kijkwijzer16 = @"kijkwijzer16";
NSString * const kGTLYouTubeContentRating_KijkwijzerRating_Kijkwijzer6 = @"kijkwijzer6";
NSString * const kGTLYouTubeContentRating_KijkwijzerRating_Kijkwijzer9 = @"kijkwijzer9";
NSString * const kGTLYouTubeContentRating_KijkwijzerRating_KijkwijzerAl = @"kijkwijzerAl";
NSString * const kGTLYouTubeContentRating_KijkwijzerRating_KijkwijzerUnrated = @"kijkwijzerUnrated";

// GTLYouTubeContentRating - KmrbRating
NSString * const kGTLYouTubeContentRating_KmrbRating_Kmrb12plus = @"kmrb12plus";
NSString * const kGTLYouTubeContentRating_KmrbRating_Kmrb15plus = @"kmrb15plus";
NSString * const kGTLYouTubeContentRating_KmrbRating_KmrbAll   = @"kmrbAll";
NSString * const kGTLYouTubeContentRating_KmrbRating_KmrbR     = @"kmrbR";
NSString * const kGTLYouTubeContentRating_KmrbRating_KmrbTeenr = @"kmrbTeenr";
NSString * const kGTLYouTubeContentRating_KmrbRating_KmrbUnrated = @"kmrbUnrated";

// GTLYouTubeContentRating - LsfRating
NSString * const kGTLYouTubeContentRating_LsfRating_LsfA       = @"lsfA";
NSString * const kGTLYouTubeContentRating_LsfRating_LsfBo      = @"lsfBo";
NSString * const kGTLYouTubeContentRating_LsfRating_LsfD       = @"lsfD";
NSString * const kGTLYouTubeContentRating_LsfRating_LsfR       = @"lsfR";
NSString * const kGTLYouTubeContentRating_LsfRating_LsfSu      = @"lsfSu";
NSString * const kGTLYouTubeContentRating_LsfRating_LsfUnrated = @"lsfUnrated";

// GTLYouTubeContentRating - MccaaRating
NSString * const kGTLYouTubeContentRating_MccaaRating_Mccaa12  = @"mccaa12";
NSString * const kGTLYouTubeContentRating_MccaaRating_Mccaa12a = @"mccaa12a";
NSString * const kGTLYouTubeContentRating_MccaaRating_Mccaa14  = @"mccaa14";
NSString * const kGTLYouTubeContentRating_MccaaRating_Mccaa15  = @"mccaa15";
NSString * const kGTLYouTubeContentRating_MccaaRating_Mccaa16  = @"mccaa16";
NSString * const kGTLYouTubeContentRating_MccaaRating_Mccaa18  = @"mccaa18";
NSString * const kGTLYouTubeContentRating_MccaaRating_MccaaPg  = @"mccaaPg";
NSString * const kGTLYouTubeContentRating_MccaaRating_MccaaU   = @"mccaaU";
NSString * const kGTLYouTubeContentRating_MccaaRating_MccaaUnrated = @"mccaaUnrated";

// GTLYouTubeContentRating - MccypRating
NSString * const kGTLYouTubeContentRating_MccypRating_Mccyp11  = @"mccyp11";
NSString * const kGTLYouTubeContentRating_MccypRating_Mccyp15  = @"mccyp15";
NSString * const kGTLYouTubeContentRating_MccypRating_Mccyp7   = @"mccyp7";
NSString * const kGTLYouTubeContentRating_MccypRating_MccypA   = @"mccypA";
NSString * const kGTLYouTubeContentRating_MccypRating_MccypUnrated = @"mccypUnrated";

// GTLYouTubeContentRating - MdaRating
NSString * const kGTLYouTubeContentRating_MdaRating_MdaG       = @"mdaG";
NSString * const kGTLYouTubeContentRating_MdaRating_MdaM18     = @"mdaM18";
NSString * const kGTLYouTubeContentRating_MdaRating_MdaNc16    = @"mdaNc16";
NSString * const kGTLYouTubeContentRating_MdaRating_MdaPg      = @"mdaPg";
NSString * const kGTLYouTubeContentRating_MdaRating_MdaPg13    = @"mdaPg13";
NSString * const kGTLYouTubeContentRating_MdaRating_MdaR21     = @"mdaR21";
NSString * const kGTLYouTubeContentRating_MdaRating_MdaUnrated = @"mdaUnrated";

// GTLYouTubeContentRating - MedietilsynetRating
NSString * const kGTLYouTubeContentRating_MedietilsynetRating_Medietilsynet11 = @"medietilsynet11";
NSString * const kGTLYouTubeContentRating_MedietilsynetRating_Medietilsynet15 = @"medietilsynet15";
NSString * const kGTLYouTubeContentRating_MedietilsynetRating_Medietilsynet18 = @"medietilsynet18";
NSString * const kGTLYouTubeContentRating_MedietilsynetRating_Medietilsynet7 = @"medietilsynet7";
NSString * const kGTLYouTubeContentRating_MedietilsynetRating_MedietilsynetA = @"medietilsynetA";
NSString * const kGTLYouTubeContentRating_MedietilsynetRating_MedietilsynetUnrated = @"medietilsynetUnrated";

// GTLYouTubeContentRating - MekuRating
NSString * const kGTLYouTubeContentRating_MekuRating_Meku12    = @"meku12";
NSString * const kGTLYouTubeContentRating_MekuRating_Meku16    = @"meku16";
NSString * const kGTLYouTubeContentRating_MekuRating_Meku18    = @"meku18";
NSString * const kGTLYouTubeContentRating_MekuRating_Meku7     = @"meku7";
NSString * const kGTLYouTubeContentRating_MekuRating_MekuS     = @"mekuS";
NSString * const kGTLYouTubeContentRating_MekuRating_MekuUnrated = @"mekuUnrated";

// GTLYouTubeContentRating - MibacRating
NSString * const kGTLYouTubeContentRating_MibacRating_MibacT   = @"mibacT";
NSString * const kGTLYouTubeContentRating_MibacRating_MibacUnrated = @"mibacUnrated";
NSString * const kGTLYouTubeContentRating_MibacRating_MibacVap = @"mibacVap";
NSString * const kGTLYouTubeContentRating_MibacRating_MibacVm12 = @"mibacVm12";
NSString * const kGTLYouTubeContentRating_MibacRating_MibacVm14 = @"mibacVm14";
NSString * const kGTLYouTubeContentRating_MibacRating_MibacVm18 = @"mibacVm18";

// GTLYouTubeContentRating - MocRating
NSString * const kGTLYouTubeContentRating_MocRating_Moc12      = @"moc12";
NSString * const kGTLYouTubeContentRating_MocRating_Moc15      = @"moc15";
NSString * const kGTLYouTubeContentRating_MocRating_Moc18      = @"moc18";
NSString * const kGTLYouTubeContentRating_MocRating_Moc7       = @"moc7";
NSString * const kGTLYouTubeContentRating_MocRating_MocBanned  = @"mocBanned";
NSString * const kGTLYouTubeContentRating_MocRating_MocE       = @"mocE";
NSString * const kGTLYouTubeContentRating_MocRating_MocT       = @"mocT";
NSString * const kGTLYouTubeContentRating_MocRating_MocUnrated = @"mocUnrated";
NSString * const kGTLYouTubeContentRating_MocRating_MocX       = @"mocX";

// GTLYouTubeContentRating - MoctwRating
NSString * const kGTLYouTubeContentRating_MoctwRating_MoctwG   = @"moctwG";
NSString * const kGTLYouTubeContentRating_MoctwRating_MoctwP   = @"moctwP";
NSString * const kGTLYouTubeContentRating_MoctwRating_MoctwPg  = @"moctwPg";
NSString * const kGTLYouTubeContentRating_MoctwRating_MoctwR   = @"moctwR";
NSString * const kGTLYouTubeContentRating_MoctwRating_MoctwUnrated = @"moctwUnrated";

// GTLYouTubeContentRating - MpaaRating
NSString * const kGTLYouTubeContentRating_MpaaRating_MpaaG     = @"mpaaG";
NSString * const kGTLYouTubeContentRating_MpaaRating_MpaaNc17  = @"mpaaNc17";
NSString * const kGTLYouTubeContentRating_MpaaRating_MpaaPg    = @"mpaaPg";
NSString * const kGTLYouTubeContentRating_MpaaRating_MpaaPg13  = @"mpaaPg13";
NSString * const kGTLYouTubeContentRating_MpaaRating_MpaaR     = @"mpaaR";
NSString * const kGTLYouTubeContentRating_MpaaRating_MpaaUnrated = @"mpaaUnrated";

// GTLYouTubeContentRating - MtrcbRating
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbG   = @"mtrcbG";
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbPg  = @"mtrcbPg";
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbR13 = @"mtrcbR13";
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbR16 = @"mtrcbR16";
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbR18 = @"mtrcbR18";
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbUnrated = @"mtrcbUnrated";
NSString * const kGTLYouTubeContentRating_MtrcbRating_MtrcbX   = @"mtrcbX";

// GTLYouTubeContentRating - NbcplRating
NSString * const kGTLYouTubeContentRating_NbcplRating_Nbcpl18plus = @"nbcpl18plus";
NSString * const kGTLYouTubeContentRating_NbcplRating_NbcplI   = @"nbcplI";
NSString * const kGTLYouTubeContentRating_NbcplRating_NbcplIi  = @"nbcplIi";
NSString * const kGTLYouTubeContentRating_NbcplRating_NbcplIii = @"nbcplIii";
NSString * const kGTLYouTubeContentRating_NbcplRating_NbcplIv  = @"nbcplIv";
NSString * const kGTLYouTubeContentRating_NbcplRating_NbcplUnrated = @"nbcplUnrated";

// GTLYouTubeContentRating - NbcRating
NSString * const kGTLYouTubeContentRating_NbcRating_Nbc12plus  = @"nbc12plus";
NSString * const kGTLYouTubeContentRating_NbcRating_Nbc15plus  = @"nbc15plus";
NSString * const kGTLYouTubeContentRating_NbcRating_Nbc18plus  = @"nbc18plus";
NSString * const kGTLYouTubeContentRating_NbcRating_Nbc18plusr = @"nbc18plusr";
NSString * const kGTLYouTubeContentRating_NbcRating_NbcG       = @"nbcG";
NSString * const kGTLYouTubeContentRating_NbcRating_NbcPg      = @"nbcPg";
NSString * const kGTLYouTubeContentRating_NbcRating_NbcPu      = @"nbcPu";
NSString * const kGTLYouTubeContentRating_NbcRating_NbcUnrated = @"nbcUnrated";

// GTLYouTubeContentRating - NfrcRating
NSString * const kGTLYouTubeContentRating_NfrcRating_NfrcA     = @"nfrcA";
NSString * const kGTLYouTubeContentRating_NfrcRating_NfrcB     = @"nfrcB";
NSString * const kGTLYouTubeContentRating_NfrcRating_NfrcC     = @"nfrcC";
NSString * const kGTLYouTubeContentRating_NfrcRating_NfrcD     = @"nfrcD";
NSString * const kGTLYouTubeContentRating_NfrcRating_NfrcUnrated = @"nfrcUnrated";
NSString * const kGTLYouTubeContentRating_NfrcRating_NfrcX     = @"nfrcX";

// GTLYouTubeContentRating - NfvcbRating
NSString * const kGTLYouTubeContentRating_NfvcbRating_Nfvcb12  = @"nfvcb12";
NSString * const kGTLYouTubeContentRating_NfvcbRating_Nfvcb12a = @"nfvcb12a";
NSString * const kGTLYouTubeContentRating_NfvcbRating_Nfvcb15  = @"nfvcb15";
NSString * const kGTLYouTubeContentRating_NfvcbRating_Nfvcb18  = @"nfvcb18";
NSString * const kGTLYouTubeContentRating_NfvcbRating_NfvcbG   = @"nfvcbG";
NSString * const kGTLYouTubeContentRating_NfvcbRating_NfvcbPg  = @"nfvcbPg";
NSString * const kGTLYouTubeContentRating_NfvcbRating_NfvcbRe  = @"nfvcbRe";
NSString * const kGTLYouTubeContentRating_NfvcbRating_NfvcbUnrated = @"nfvcbUnrated";

// GTLYouTubeContentRating - NkclvRating
NSString * const kGTLYouTubeContentRating_NkclvRating_Nkclv12plus = @"nkclv12plus";
NSString * const kGTLYouTubeContentRating_NkclvRating_Nkclv18plus = @"nkclv18plus";
NSString * const kGTLYouTubeContentRating_NkclvRating_Nkclv7plus = @"nkclv7plus";
NSString * const kGTLYouTubeContentRating_NkclvRating_NkclvU   = @"nkclvU";
NSString * const kGTLYouTubeContentRating_NkclvRating_NkclvUnrated = @"nkclvUnrated";

// GTLYouTubeContentRating - OflcRating
NSString * const kGTLYouTubeContentRating_OflcRating_OflcG     = @"oflcG";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcM     = @"oflcM";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcPg    = @"oflcPg";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcR13   = @"oflcR13";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcR15   = @"oflcR15";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcR16   = @"oflcR16";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcR18   = @"oflcR18";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcRp13  = @"oflcRp13";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcRp16  = @"oflcRp16";
NSString * const kGTLYouTubeContentRating_OflcRating_OflcUnrated = @"oflcUnrated";

// GTLYouTubeContentRating - PefilmRating
NSString * const kGTLYouTubeContentRating_PefilmRating_Pefilm14 = @"pefilm14";
NSString * const kGTLYouTubeContentRating_PefilmRating_Pefilm18 = @"pefilm18";
NSString * const kGTLYouTubeContentRating_PefilmRating_PefilmPg = @"pefilmPg";
NSString * const kGTLYouTubeContentRating_PefilmRating_PefilmPt = @"pefilmPt";
NSString * const kGTLYouTubeContentRating_PefilmRating_PefilmUnrated = @"pefilmUnrated";

// GTLYouTubeContentRating - RcnofRating
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofI   = @"rcnofI";
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofIi  = @"rcnofIi";
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofIii = @"rcnofIii";
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofIv  = @"rcnofIv";
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofUnrated = @"rcnofUnrated";
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofV   = @"rcnofV";
NSString * const kGTLYouTubeContentRating_RcnofRating_RcnofVi  = @"rcnofVi";

// GTLYouTubeContentRating - ResorteviolenciaRating
NSString * const kGTLYouTubeContentRating_ResorteviolenciaRating_ResorteviolenciaA = @"resorteviolenciaA";
NSString * const kGTLYouTubeContentRating_ResorteviolenciaRating_ResorteviolenciaB = @"resorteviolenciaB";
NSString * const kGTLYouTubeContentRating_ResorteviolenciaRating_ResorteviolenciaC = @"resorteviolenciaC";
NSString * const kGTLYouTubeContentRating_ResorteviolenciaRating_ResorteviolenciaD = @"resorteviolenciaD";
NSString * const kGTLYouTubeContentRating_ResorteviolenciaRating_ResorteviolenciaE = @"resorteviolenciaE";
NSString * const kGTLYouTubeContentRating_ResorteviolenciaRating_ResorteviolenciaUnrated = @"resorteviolenciaUnrated";

// GTLYouTubeContentRating - RtcRating
NSString * const kGTLYouTubeContentRating_RtcRating_RtcA       = @"rtcA";
NSString * const kGTLYouTubeContentRating_RtcRating_RtcAa      = @"rtcAa";
NSString * const kGTLYouTubeContentRating_RtcRating_RtcB       = @"rtcB";
NSString * const kGTLYouTubeContentRating_RtcRating_RtcB15     = @"rtcB15";
NSString * const kGTLYouTubeContentRating_RtcRating_RtcC       = @"rtcC";
NSString * const kGTLYouTubeContentRating_RtcRating_RtcD       = @"rtcD";
NSString * const kGTLYouTubeContentRating_RtcRating_RtcUnrated = @"rtcUnrated";

// GTLYouTubeContentRating - RteRating
NSString * const kGTLYouTubeContentRating_RteRating_RteCh      = @"rteCh";
NSString * const kGTLYouTubeContentRating_RteRating_RteGa      = @"rteGa";
NSString * const kGTLYouTubeContentRating_RteRating_RteMa      = @"rteMa";
NSString * const kGTLYouTubeContentRating_RteRating_RtePs      = @"rtePs";
NSString * const kGTLYouTubeContentRating_RteRating_RteUnrated = @"rteUnrated";

// GTLYouTubeContentRating - RussiaRating
NSString * const kGTLYouTubeContentRating_RussiaRating_Russia0 = @"russia0";
NSString * const kGTLYouTubeContentRating_RussiaRating_Russia12 = @"russia12";
NSString * const kGTLYouTubeContentRating_RussiaRating_Russia16 = @"russia16";
NSString * const kGTLYouTubeContentRating_RussiaRating_Russia18 = @"russia18";
NSString * const kGTLYouTubeContentRating_RussiaRating_Russia6 = @"russia6";
NSString * const kGTLYouTubeContentRating_RussiaRating_RussiaUnrated = @"russiaUnrated";

// GTLYouTubeContentRating - SkfilmRating
NSString * const kGTLYouTubeContentRating_SkfilmRating_SkfilmG = @"skfilmG";
NSString * const kGTLYouTubeContentRating_SkfilmRating_SkfilmP2 = @"skfilmP2";
NSString * const kGTLYouTubeContentRating_SkfilmRating_SkfilmP5 = @"skfilmP5";
NSString * const kGTLYouTubeContentRating_SkfilmRating_SkfilmP8 = @"skfilmP8";
NSString * const kGTLYouTubeContentRating_SkfilmRating_SkfilmUnrated = @"skfilmUnrated";

// GTLYouTubeContentRating - SmaisRating
NSString * const kGTLYouTubeContentRating_SmaisRating_Smais12  = @"smais12";
NSString * const kGTLYouTubeContentRating_SmaisRating_Smais14  = @"smais14";
NSString * const kGTLYouTubeContentRating_SmaisRating_Smais16  = @"smais16";
NSString * const kGTLYouTubeContentRating_SmaisRating_Smais18  = @"smais18";
NSString * const kGTLYouTubeContentRating_SmaisRating_Smais7   = @"smais7";
NSString * const kGTLYouTubeContentRating_SmaisRating_SmaisL   = @"smaisL";
NSString * const kGTLYouTubeContentRating_SmaisRating_SmaisUnrated = @"smaisUnrated";

// GTLYouTubeContentRating - SmsaRating
NSString * const kGTLYouTubeContentRating_SmsaRating_Smsa11    = @"smsa11";
NSString * const kGTLYouTubeContentRating_SmsaRating_Smsa15    = @"smsa15";
NSString * const kGTLYouTubeContentRating_SmsaRating_Smsa7     = @"smsa7";
NSString * const kGTLYouTubeContentRating_SmsaRating_SmsaA     = @"smsaA";
NSString * const kGTLYouTubeContentRating_SmsaRating_SmsaUnrated = @"smsaUnrated";

// GTLYouTubeContentRating - TvpgRating
NSString * const kGTLYouTubeContentRating_TvpgRating_Pg14      = @"pg14";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgG     = @"tvpgG";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgMa    = @"tvpgMa";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgPg    = @"tvpgPg";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgUnrated = @"tvpgUnrated";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgY     = @"tvpgY";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgY7    = @"tvpgY7";
NSString * const kGTLYouTubeContentRating_TvpgRating_TvpgY7Fv  = @"tvpgY7Fv";

// GTLYouTubeContentRating - YtRating
NSString * const kGTLYouTubeContentRating_YtRating_YtAgeRestricted = @"ytAgeRestricted";

// GTLYouTubeInvideoPosition - CornerPosition
NSString * const kGTLYouTubeInvideoPosition_CornerPosition_BottomLeft = @"bottomLeft";
NSString * const kGTLYouTubeInvideoPosition_CornerPosition_BottomRight = @"bottomRight";
NSString * const kGTLYouTubeInvideoPosition_CornerPosition_TopLeft = @"topLeft";
NSString * const kGTLYouTubeInvideoPosition_CornerPosition_TopRight = @"topRight";

// GTLYouTubeInvideoPosition - Type
NSString * const kGTLYouTubeInvideoPosition_Type_Corner = @"corner";

// GTLYouTubeInvideoTiming - Type
NSString * const kGTLYouTubeInvideoTiming_Type_OffsetFromEnd   = @"offsetFromEnd";
NSString * const kGTLYouTubeInvideoTiming_Type_OffsetFromStart = @"offsetFromStart";

// GTLYouTubeLiveBroadcastStatus - LifeCycleStatus
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Abandoned = @"abandoned";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Complete = @"complete";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_CompleteStarting = @"completeStarting";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Created = @"created";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Live = @"live";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_LiveStarting = @"liveStarting";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Ready = @"ready";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Reclaimed = @"reclaimed";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Revoked = @"revoked";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_Testing = @"testing";
NSString * const kGTLYouTubeLiveBroadcastStatus_LifeCycleStatus_TestStarting = @"testStarting";

// GTLYouTubeLiveBroadcastStatus - LiveBroadcastPriority
NSString * const kGTLYouTubeLiveBroadcastStatus_LiveBroadcastPriority_High = @"high";
NSString * const kGTLYouTubeLiveBroadcastStatus_LiveBroadcastPriority_Low = @"low";
NSString * const kGTLYouTubeLiveBroadcastStatus_LiveBroadcastPriority_Normal = @"normal";

// GTLYouTubeLiveBroadcastStatus - PrivacyStatus
NSString * const kGTLYouTubeLiveBroadcastStatus_PrivacyStatus_Private = @"private";
NSString * const kGTLYouTubeLiveBroadcastStatus_PrivacyStatus_Public = @"public";
NSString * const kGTLYouTubeLiveBroadcastStatus_PrivacyStatus_Unlisted = @"unlisted";

// GTLYouTubeLiveBroadcastStatus - RecordingStatus
NSString * const kGTLYouTubeLiveBroadcastStatus_RecordingStatus_NotRecording = @"notRecording";
NSString * const kGTLYouTubeLiveBroadcastStatus_RecordingStatus_Recorded = @"recorded";
NSString * const kGTLYouTubeLiveBroadcastStatus_RecordingStatus_Recording = @"recording";

// GTLYouTubeLiveStreamStatus - StreamStatus
NSString * const kGTLYouTubeLiveStreamStatus_StreamStatus_Active = @"active";
NSString * const kGTLYouTubeLiveStreamStatus_StreamStatus_Created = @"created";
NSString * const kGTLYouTubeLiveStreamStatus_StreamStatus_Error = @"error";
NSString * const kGTLYouTubeLiveStreamStatus_StreamStatus_Inactive = @"inactive";
NSString * const kGTLYouTubeLiveStreamStatus_StreamStatus_Ready = @"ready";

// GTLYouTubePlaylistItemStatus - PrivacyStatus
NSString * const kGTLYouTubePlaylistItemStatus_PrivacyStatus_Private = @"private";
NSString * const kGTLYouTubePlaylistItemStatus_PrivacyStatus_Public = @"public";
NSString * const kGTLYouTubePlaylistItemStatus_PrivacyStatus_Unlisted = @"unlisted";

// GTLYouTubePlaylistStatus - PrivacyStatus
NSString * const kGTLYouTubePlaylistStatus_PrivacyStatus_Private = @"private";
NSString * const kGTLYouTubePlaylistStatus_PrivacyStatus_Public = @"public";
NSString * const kGTLYouTubePlaylistStatus_PrivacyStatus_Unlisted = @"unlisted";

// GTLYouTubePromotedItemId - Type
NSString * const kGTLYouTubePromotedItemId_Type_RecentUpload = @"recentUpload";
NSString * const kGTLYouTubePromotedItemId_Type_Video        = @"video";
NSString * const kGTLYouTubePromotedItemId_Type_Website      = @"website";

// GTLYouTubeSearchResultSnippet - LiveBroadcastContent
NSString * const kGTLYouTubeSearchResultSnippet_LiveBroadcastContent_Live = @"live";
NSString * const kGTLYouTubeSearchResultSnippet_LiveBroadcastContent_None = @"none";
NSString * const kGTLYouTubeSearchResultSnippet_LiveBroadcastContent_Upcoming = @"upcoming";

// GTLYouTubeSubscriptionContentDetails - ActivityType
NSString * const kGTLYouTubeSubscriptionContentDetails_ActivityType_All = @"all";
NSString * const kGTLYouTubeSubscriptionContentDetails_ActivityType_Uploads = @"uploads";

// GTLYouTubeVideoAgeGating - VideoGameRating
NSString * const kGTLYouTubeVideoAgeGating_VideoGameRating_Anyone = @"anyone";
NSString * const kGTLYouTubeVideoAgeGating_VideoGameRating_M15Plus = @"m15Plus";
NSString * const kGTLYouTubeVideoAgeGating_VideoGameRating_M16Plus = @"m16Plus";
NSString * const kGTLYouTubeVideoAgeGating_VideoGameRating_M17Plus = @"m17Plus";

// GTLYouTubeVideoContentDetails - Caption
NSString * const kGTLYouTubeVideoContentDetails_Caption_False = @"false";
NSString * const kGTLYouTubeVideoContentDetails_Caption_True  = @"true";

// GTLYouTubeVideoContentDetails - Definition
NSString * const kGTLYouTubeVideoContentDetails_Definition_Hd = @"hd";
NSString * const kGTLYouTubeVideoContentDetails_Definition_Sd = @"sd";

// GTLYouTubeVideoConversionPing - Context
NSString * const kGTLYouTubeVideoConversionPing_Context_Comment = @"comment";
NSString * const kGTLYouTubeVideoConversionPing_Context_Dislike = @"dislike";
NSString * const kGTLYouTubeVideoConversionPing_Context_Like   = @"like";
NSString * const kGTLYouTubeVideoConversionPing_Context_Share  = @"share";

// GTLYouTubeVideoFileDetails - FileType
NSString * const kGTLYouTubeVideoFileDetails_FileType_Archive  = @"archive";
NSString * const kGTLYouTubeVideoFileDetails_FileType_Audio    = @"audio";
NSString * const kGTLYouTubeVideoFileDetails_FileType_Document = @"document";
NSString * const kGTLYouTubeVideoFileDetails_FileType_Image    = @"image";
NSString * const kGTLYouTubeVideoFileDetails_FileType_Other    = @"other";
NSString * const kGTLYouTubeVideoFileDetails_FileType_Project  = @"project";
NSString * const kGTLYouTubeVideoFileDetails_FileType_Video    = @"video";

// GTLYouTubeVideoFileDetailsVideoStream - Rotation
NSString * const kGTLYouTubeVideoFileDetailsVideoStream_Rotation_Clockwise = @"clockwise";
NSString * const kGTLYouTubeVideoFileDetailsVideoStream_Rotation_CounterClockwise = @"counterClockwise";
NSString * const kGTLYouTubeVideoFileDetailsVideoStream_Rotation_None = @"none";
NSString * const kGTLYouTubeVideoFileDetailsVideoStream_Rotation_Other = @"other";
NSString * const kGTLYouTubeVideoFileDetailsVideoStream_Rotation_UpsideDown = @"upsideDown";

// GTLYouTubeVideoProcessingDetails - ProcessingFailureReason
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingFailureReason_Other = @"other";
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingFailureReason_StreamingFailed = @"streamingFailed";
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingFailureReason_TranscodeFailed = @"transcodeFailed";
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingFailureReason_UploadFailed = @"uploadFailed";

// GTLYouTubeVideoProcessingDetails - ProcessingStatus
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingStatus_Failed = @"failed";
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingStatus_Processing = @"processing";
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingStatus_Succeeded = @"succeeded";
NSString * const kGTLYouTubeVideoProcessingDetails_ProcessingStatus_Terminated = @"terminated";

// GTLYouTubeVideoRating - Rating
NSString * const kGTLYouTubeVideoRating_Rating_Dislike     = @"dislike";
NSString * const kGTLYouTubeVideoRating_Rating_Like        = @"like";
NSString * const kGTLYouTubeVideoRating_Rating_None        = @"none";
NSString * const kGTLYouTubeVideoRating_Rating_Unspecified = @"unspecified";

// GTLYouTubeVideoSnippet - LiveBroadcastContent
NSString * const kGTLYouTubeVideoSnippet_LiveBroadcastContent_Live = @"live";
NSString * const kGTLYouTubeVideoSnippet_LiveBroadcastContent_None = @"none";
NSString * const kGTLYouTubeVideoSnippet_LiveBroadcastContent_Upcoming = @"upcoming";

// GTLYouTubeVideoStatus - FailureReason
NSString * const kGTLYouTubeVideoStatus_FailureReason_Codec    = @"codec";
NSString * const kGTLYouTubeVideoStatus_FailureReason_Conversion = @"conversion";
NSString * const kGTLYouTubeVideoStatus_FailureReason_EmptyFile = @"emptyFile";
NSString * const kGTLYouTubeVideoStatus_FailureReason_InvalidFile = @"invalidFile";
NSString * const kGTLYouTubeVideoStatus_FailureReason_TooSmall = @"tooSmall";
NSString * const kGTLYouTubeVideoStatus_FailureReason_UploadAborted = @"uploadAborted";

// GTLYouTubeVideoStatus - License
NSString * const kGTLYouTubeVideoStatus_License_CreativeCommon = @"creativeCommon";
NSString * const kGTLYouTubeVideoStatus_License_Youtube        = @"youtube";

// GTLYouTubeVideoStatus - PrivacyStatus
NSString * const kGTLYouTubeVideoStatus_PrivacyStatus_Private  = @"private";
NSString * const kGTLYouTubeVideoStatus_PrivacyStatus_Public   = @"public";
NSString * const kGTLYouTubeVideoStatus_PrivacyStatus_Unlisted = @"unlisted";

// GTLYouTubeVideoStatus - RejectionReason
NSString * const kGTLYouTubeVideoStatus_RejectionReason_Claim  = @"claim";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_Copyright = @"copyright";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_Duplicate = @"duplicate";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_Inappropriate = @"inappropriate";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_Length = @"length";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_TermsOfUse = @"termsOfUse";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_Trademark = @"trademark";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_UploaderAccountClosed = @"uploaderAccountClosed";
NSString * const kGTLYouTubeVideoStatus_RejectionReason_UploaderAccountSuspended = @"uploaderAccountSuspended";

// GTLYouTubeVideoStatus - UploadStatus
NSString * const kGTLYouTubeVideoStatus_UploadStatus_Deleted   = @"deleted";
NSString * const kGTLYouTubeVideoStatus_UploadStatus_Failed    = @"failed";
NSString * const kGTLYouTubeVideoStatus_UploadStatus_Processed = @"processed";
NSString * const kGTLYouTubeVideoStatus_UploadStatus_Rejected  = @"rejected";
NSString * const kGTLYouTubeVideoStatus_UploadStatus_Uploaded  = @"uploaded";

// GTLYouTubeVideoSuggestions - EditorSuggestions
NSString * const kGTLYouTubeVideoSuggestions_EditorSuggestions_AudioQuietAudioSwap = @"audioQuietAudioSwap";
NSString * const kGTLYouTubeVideoSuggestions_EditorSuggestions_VideoAutoLevels = @"videoAutoLevels";
NSString * const kGTLYouTubeVideoSuggestions_EditorSuggestions_VideoCrop = @"videoCrop";
NSString * const kGTLYouTubeVideoSuggestions_EditorSuggestions_VideoStabilize = @"videoStabilize";

// GTLYouTubeVideoSuggestions - ProcessingErrors
NSString * const kGTLYouTubeVideoSuggestions_ProcessingErrors_ArchiveFile = @"archiveFile";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingErrors_AudioFile = @"audioFile";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingErrors_DocFile = @"docFile";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingErrors_ImageFile = @"imageFile";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingErrors_NotAVideoFile = @"notAVideoFile";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingErrors_ProjectFile = @"projectFile";

// GTLYouTubeVideoSuggestions - ProcessingHints
NSString * const kGTLYouTubeVideoSuggestions_ProcessingHints_NonStreamableMov = @"nonStreamableMov";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingHints_SendBestQualityVideo = @"sendBestQualityVideo";

// GTLYouTubeVideoSuggestions - ProcessingWarnings
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_HasEditlist = @"hasEditlist";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_InconsistentResolution = @"inconsistentResolution";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_ProblematicAudioCodec = @"problematicAudioCodec";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_ProblematicVideoCodec = @"problematicVideoCodec";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_UnknownAudioCodec = @"unknownAudioCodec";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_UnknownContainer = @"unknownContainer";
NSString * const kGTLYouTubeVideoSuggestions_ProcessingWarnings_UnknownVideoCodec = @"unknownVideoCodec";

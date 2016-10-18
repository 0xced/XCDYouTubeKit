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
//  GTLYouTubeVideoSnippet.h
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
//   GTLYouTubeVideoSnippet (0 custom class methods, 12 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeThumbnailDetails;
@class GTLYouTubeVideoLocalization;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoSnippet
//

// Basic details about a video, including title, description, uploader,
// thumbnails and category.

@interface GTLYouTubeVideoSnippet : GTLObject

// The YouTube video category associated with the video.
@property (nonatomic, copy) NSString *categoryId;

// The ID that YouTube uses to uniquely identify the channel that the video was
// uploaded to.
@property (nonatomic, copy) NSString *channelId;

// Channel title for the channel that the video belongs to.
@property (nonatomic, copy) NSString *channelTitle;

// The default_audio_language property specifies the language spoken in the
// video's default audio track.
@property (nonatomic, copy) NSString *defaultAudioLanguage;

// The language of the videos's default snippet.
@property (nonatomic, copy) NSString *defaultLanguage;

// The video's description.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

// Indicates if the video is an upcoming/active live broadcast. Or it's "none"
// if the video is not an upcoming/active live broadcast.
@property (nonatomic, copy) NSString *liveBroadcastContent;

// Localized snippet selected with the hl parameter. If no such localization
// exists, this field is populated with the default snippet. (Read-only)
@property (nonatomic, retain) GTLYouTubeVideoLocalization *localized;

// The date and time that the video was uploaded. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// A list of keyword tags associated with the video. Tags may contain spaces.
@property (nonatomic, retain) NSArray *tags;  // of NSString

// A map of thumbnail images associated with the video. For each object in the
// map, the key is the name of the thumbnail image, and the value is an object
// that contains other information about the thumbnail.
@property (nonatomic, retain) GTLYouTubeThumbnailDetails *thumbnails;

// The video's title.
@property (nonatomic, copy) NSString *title;

@end

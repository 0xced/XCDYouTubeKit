/* Copyright (c) 2015 Google Inc.
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
//  GTLYouTubePlaylistSnippet.h
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
//   GTLYouTubePlaylistSnippet (0 custom class methods, 9 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubePlaylistLocalization;
@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubePlaylistSnippet
//

// Basic details about a playlist, including title, description and thumbnails.

@interface GTLYouTubePlaylistSnippet : GTLObject

// The ID that YouTube uses to uniquely identify the channel that published the
// playlist.
@property (nonatomic, copy) NSString *channelId;

// The channel title of the channel that the video belongs to.
@property (nonatomic, copy) NSString *channelTitle;

// The language of the playlist's default title and description.
@property (nonatomic, copy) NSString *defaultLanguage;

// The playlist's description.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

// Localized title and description, read-only.
@property (nonatomic, retain) GTLYouTubePlaylistLocalization *localized;

// The date and time that the playlist was created. The value is specified in
// ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// Keyword tags associated with the playlist.
@property (nonatomic, retain) NSArray *tags;  // of NSString

// A map of thumbnail images associated with the playlist. For each object in
// the map, the key is the name of the thumbnail image, and the value is an
// object that contains other information about the thumbnail.
@property (nonatomic, retain) GTLYouTubeThumbnailDetails *thumbnails;

// The playlist's title.
@property (nonatomic, copy) NSString *title;

@end

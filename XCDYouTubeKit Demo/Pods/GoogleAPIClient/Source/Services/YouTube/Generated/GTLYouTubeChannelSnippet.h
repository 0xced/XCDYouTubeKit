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
//  GTLYouTubeChannelSnippet.h
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
//   GTLYouTubeChannelSnippet (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeChannelLocalization;
@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeChannelSnippet
//

// Basic details about a channel, including title, description and thumbnails.
// Next available id: 15.

@interface GTLYouTubeChannelSnippet : GTLObject

// The country of the channel.
@property (nonatomic, copy) NSString *country;

// The custom url of the channel.
@property (nonatomic, copy) NSString *customUrl;

// The language of the channel's default title and description.
@property (nonatomic, copy) NSString *defaultLanguage;

// The description of the channel.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

// Localized title and description, read-only.
@property (nonatomic, retain) GTLYouTubeChannelLocalization *localized;

// The date and time that the channel was created. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// A map of thumbnail images associated with the channel. For each object in the
// map, the key is the name of the thumbnail image, and the value is an object
// that contains other information about the thumbnail.
@property (nonatomic, retain) GTLYouTubeThumbnailDetails *thumbnails;

// The channel's title.
@property (nonatomic, copy) NSString *title;

@end

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
//  GTLYouTubePlaylistItemSnippet.h
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
//   GTLYouTubePlaylistItemSnippet (0 custom class methods, 9 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeResourceId;
@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubePlaylistItemSnippet
//

// Basic details about a playlist, including title, description and thumbnails.

@interface GTLYouTubePlaylistItemSnippet : GTLObject

// The ID that YouTube uses to uniquely identify the user that added the item to
// the playlist.
@property (nonatomic, copy) NSString *channelId;

// Channel title for the channel that the playlist item belongs to.
@property (nonatomic, copy) NSString *channelTitle;

// The item's description.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

// The ID that YouTube uses to uniquely identify the playlist that the playlist
// item is in.
@property (nonatomic, copy) NSString *playlistId;

// The order in which the item appears in the playlist. The value uses a
// zero-based index, so the first item has a position of 0, the second item has
// a position of 1, and so forth.
@property (nonatomic, retain) NSNumber *position;  // unsignedIntValue

// The date and time that the item was added to the playlist. The value is
// specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// The id object contains information that can be used to uniquely identify the
// resource that is included in the playlist as the playlist item.
@property (nonatomic, retain) GTLYouTubeResourceId *resourceId;

// A map of thumbnail images associated with the playlist item. For each object
// in the map, the key is the name of the thumbnail image, and the value is an
// object that contains other information about the thumbnail.
@property (nonatomic, retain) GTLYouTubeThumbnailDetails *thumbnails;

// The item's title.
@property (nonatomic, copy) NSString *title;

@end

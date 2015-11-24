/* Copyright (c) 2013 Google Inc.
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
//  GTLYouTubePlaylistItem.h
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
//   GTLYouTubePlaylistItem (0 custom class methods, 6 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubePlaylistItemContentDetails;
@class GTLYouTubePlaylistItemSnippet;
@class GTLYouTubePlaylistItemStatus;

// ----------------------------------------------------------------------------
//
//   GTLYouTubePlaylistItem
//

// A playlistItem resource identifies another resource, such as a video, that is
// included in a playlist. In addition, the playlistItem resource contains
// details about the included resource that pertain specifically to how that
// resource is used in that playlist.
// YouTube uses playlists to identify special collections of videos for a
// channel, such as:
// - uploaded videos
// - favorite videos
// - positively rated (liked) videos
// - watch history
// - watch later To be more specific, these lists are associated with a channel,
// which is a collection of a person, group, or company's videos, playlists, and
// other YouTube information.
// You can retrieve the playlist IDs for each of these lists from the channel
// resource for a given channel. You can then use the playlistItems.list method
// to retrieve any of those lists. You can also add or remove items from those
// lists by calling the playlistItems.insert and playlistItems.delete methods.
// For example, if a user gives a positive rating to a video, you would insert
// that video into the liked videos playlist for that user's channel.

@interface GTLYouTubePlaylistItem : GTLObject

// The contentDetails object is included in the resource if the included item is
// a YouTube video. The object contains additional information about the video.
@property (retain) GTLYouTubePlaylistItemContentDetails *contentDetails;

// Etag of this resource.
@property (copy) NSString *ETag;

// The ID that YouTube uses to uniquely identify the playlist item.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#playlistItem".
@property (copy) NSString *kind;

// The snippet object contains basic details about the playlist item, such as
// its title and position in the playlist.
@property (retain) GTLYouTubePlaylistItemSnippet *snippet;

// The status object contains information about the playlist item's privacy
// status.
@property (retain) GTLYouTubePlaylistItemStatus *status;

@end

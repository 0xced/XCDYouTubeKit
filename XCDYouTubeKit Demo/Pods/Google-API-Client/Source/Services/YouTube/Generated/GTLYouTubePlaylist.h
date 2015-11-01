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
//  GTLYouTubePlaylist.h
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
//   GTLYouTubePlaylist (0 custom class methods, 7 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubePlaylistContentDetails;
@class GTLYouTubePlaylistPlayer;
@class GTLYouTubePlaylistSnippet;
@class GTLYouTubePlaylistStatus;

// ----------------------------------------------------------------------------
//
//   GTLYouTubePlaylist
//

// A playlist resource represents a YouTube playlist. A playlist is a collection
// of videos that can be viewed sequentially and shared with other users. A
// playlist can contain up to 200 videos, and YouTube does not limit the number
// of playlists that each user creates. By default, playlists are publicly
// visible to other users, but playlists can be public or private.
// YouTube also uses playlists to identify special collections of videos for a
// channel, such as:
// - uploaded videos
// - favorite videos
// - positively rated (liked) videos
// - watch history
// - watch later To be more specific, these lists are associated with a channel,
// which is a collection of a person, group, or company's videos, playlists, and
// other YouTube information. You can retrieve the playlist IDs for each of
// these lists from the channel resource for a given channel.
// You can then use the playlistItems.list method to retrieve any of those
// lists. You can also add or remove items from those lists by calling the
// playlistItems.insert and playlistItems.delete methods.

@interface GTLYouTubePlaylist : GTLObject

// The contentDetails object contains information like video count.
@property (retain) GTLYouTubePlaylistContentDetails *contentDetails;

// Etag of this resource.
@property (copy) NSString *ETag;

// The ID that YouTube uses to uniquely identify the playlist.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#playlist".
@property (copy) NSString *kind;

// The player object contains information that you would use to play the
// playlist in an embedded player.
@property (retain) GTLYouTubePlaylistPlayer *player;

// The snippet object contains basic details about the playlist, such as its
// title and description.
@property (retain) GTLYouTubePlaylistSnippet *snippet;

// The status object contains status information for the playlist.
@property (retain) GTLYouTubePlaylistStatus *status;

@end

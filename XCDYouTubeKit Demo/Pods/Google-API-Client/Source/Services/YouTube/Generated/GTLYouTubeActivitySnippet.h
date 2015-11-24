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
//  GTLYouTubeActivitySnippet.h
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
//   GTLYouTubeActivitySnippet (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeActivitySnippet
//

// Basic details about an activity, including title, description, thumbnails,
// activity type and group.

@interface GTLYouTubeActivitySnippet : GTLObject

// The ID that YouTube uses to uniquely identify the channel associated with the
// activity.
@property (copy) NSString *channelId;

// Channel title for the channel responsible for this activity
@property (copy) NSString *channelTitle;

// The description of the resource primarily associated with the activity.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (copy) NSString *descriptionProperty;

// The group ID associated with the activity. A group ID identifies user events
// that are associated with the same user and resource. For example, if a user
// rates a video and marks the same video as a favorite, the entries for those
// events would have the same group ID in the user's activity feed. In your user
// interface, you can avoid repetition by grouping events with the same groupId
// value.
@property (copy) NSString *groupId;

// The date and time that the video was uploaded. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (retain) GTLDateTime *publishedAt;

// A map of thumbnail images associated with the resource that is primarily
// associated with the activity. For each object in the map, the key is the name
// of the thumbnail image, and the value is an object that contains other
// information about the thumbnail.
@property (retain) GTLYouTubeThumbnailDetails *thumbnails;

// The title of the resource primarily associated with the activity.
@property (copy) NSString *title;

// The type of activity that the resource describes.
@property (copy) NSString *type;

@end

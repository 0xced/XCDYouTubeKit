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
//  GTLYouTubeVideoSnippet.h
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
//   GTLYouTubeVideoSnippet (0 custom class methods, 9 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoSnippet
//

// Basic details about a video, including title, description, uploader,
// thumbnails and category.

@interface GTLYouTubeVideoSnippet : GTLObject

// The YouTube video category associated with the video.
@property (copy) NSString *categoryId;

// The ID that YouTube uses to uniquely identify the channel that the video was
// uploaded to.
@property (copy) NSString *channelId;

// Channel title for the channel that the video belongs to.
@property (copy) NSString *channelTitle;

// The video's description.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (copy) NSString *descriptionProperty;

// Indicates if the video is an upcoming/active live broadcast. Or it's "none"
// if the video is not an upcoming/active live broadcast.
@property (copy) NSString *liveBroadcastContent;

// The date and time that the video was uploaded. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (retain) GTLDateTime *publishedAt;

// A list of keyword tags associated with the video. Tags may contain spaces.
// This field is only visible to the video's uploader.
@property (retain) NSArray *tags;  // of NSString

// A map of thumbnail images associated with the video. For each object in the
// map, the key is the name of the thumbnail image, and the value is an object
// that contains other information about the thumbnail.
@property (retain) GTLYouTubeThumbnailDetails *thumbnails;

// The video's title.
@property (copy) NSString *title;

@end

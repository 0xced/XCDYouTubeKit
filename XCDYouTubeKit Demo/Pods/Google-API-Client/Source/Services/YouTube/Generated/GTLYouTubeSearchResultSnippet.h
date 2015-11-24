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
//  GTLYouTubeSearchResultSnippet.h
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
//   GTLYouTubeSearchResultSnippet (0 custom class methods, 7 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeSearchResultSnippet
//

// Basic details about a search result, including title, description and
// thumbnails of the item referenced by the search result.

@interface GTLYouTubeSearchResultSnippet : GTLObject

// The value that YouTube uses to uniquely identify the channel that published
// the resource that the search result identifies.
@property (copy) NSString *channelId;

// The title of the channel that published the resource that the search result
// identifies.
@property (copy) NSString *channelTitle;

// A description of the search result.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (copy) NSString *descriptionProperty;

// It indicates if the resource (video or channel) has upcoming/active live
// broadcast content. Or it's "none" if there is not any upcoming/active live
// broadcasts.
@property (copy) NSString *liveBroadcastContent;

// The creation date and time of the resource that the search result identifies.
// The value is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (retain) GTLDateTime *publishedAt;

// A map of thumbnail images associated with the search result. For each object
// in the map, the key is the name of the thumbnail image, and the value is an
// object that contains other information about the thumbnail.
@property (retain) GTLYouTubeThumbnailDetails *thumbnails;

// The title of the search result.
@property (copy) NSString *title;

@end

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
//  GTLYouTubeSearchResult.h
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
//   GTLYouTubeSearchResult (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeResourceId;
@class GTLYouTubeSearchResultSnippet;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeSearchResult
//

// A search result contains information about a YouTube video, channel, or
// playlist that matches the search parameters specified in an API request.
// While a search result points to a uniquely identifiable resource, like a
// video, it does not have its own persistent data.

@interface GTLYouTubeSearchResult : GTLObject

// Etag of this resource.
@property (copy) NSString *ETag;

// The id object contains information that can be used to uniquely identify the
// resource that matches the search request.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (retain) GTLYouTubeResourceId *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#searchResult".
@property (copy) NSString *kind;

// The snippet object contains basic details about a search result, such as its
// title or description. For example, if the search result is a video, then the
// title will be the video's title and the description will be the video's
// description.
@property (retain) GTLYouTubeSearchResultSnippet *snippet;

@end

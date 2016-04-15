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
//  GTLYouTubeVideoSuggestionsTagSuggestion.h
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
//   GTLYouTubeVideoSuggestionsTagSuggestion (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoSuggestionsTagSuggestion
//

// A single tag suggestion with it's relevance information.

@interface GTLYouTubeVideoSuggestionsTagSuggestion : GTLObject

// A set of video categories for which the tag is relevant. You can use this
// information to display appropriate tag suggestions based on the video
// category that the video uploader associates with the video. By default, tag
// suggestions are relevant for all categories if there are no restricts defined
// for the keyword.
@property (nonatomic, retain) NSArray *categoryRestricts;  // of NSString

// The keyword tag suggested for the video.
@property (nonatomic, copy) NSString *tag;

@end

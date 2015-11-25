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
//  GTLYouTubeGuideCategory.h
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
//   GTLYouTubeGuideCategory (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeGuideCategorySnippet;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeGuideCategory
//

// A guideCategory resource identifies a category that YouTube algorithmically
// assigns based on a channel's content or other indicators, such as the
// channel's popularity. The list is similar to video categories, with the
// difference being that a video's uploader can assign a video category but only
// YouTube can assign a channel category.

@interface GTLYouTubeGuideCategory : GTLObject

// Etag of this resource.
@property (copy) NSString *ETag;

// The ID that YouTube uses to uniquely identify the guide category.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#guideCategory".
@property (copy) NSString *kind;

// The snippet object contains basic details about the category, such as its
// title.
@property (retain) GTLYouTubeGuideCategorySnippet *snippet;

@end

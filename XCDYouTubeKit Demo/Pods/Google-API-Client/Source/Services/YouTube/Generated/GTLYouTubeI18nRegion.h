/* Copyright (c) 2014 Google Inc.
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
//  GTLYouTubeI18nRegion.h
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
//   GTLYouTubeI18nRegion (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeI18nRegionSnippet;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeI18nRegion
//

// A i18nRegion resource identifies a region where YouTube is available.

@interface GTLYouTubeI18nRegion : GTLObject

// Etag of this resource.
@property (copy) NSString *ETag;

// The ID that YouTube uses to uniquely identify the i18n region.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#i18nRegion".
@property (copy) NSString *kind;

// The snippet object contains basic details about the i18n region, such as
// region code and human-readable name.
@property (retain) GTLYouTubeI18nRegionSnippet *snippet;

@end

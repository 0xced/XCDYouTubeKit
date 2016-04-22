/* Copyright (c) 2016 Google Inc.
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
//  GTLYouTubeI18nLanguageListResponse.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Supports core YouTube features, such as uploading videos, creating and
//   managing playlists, searching for content, and much more.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLYouTubeI18nLanguageListResponse (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeI18nLanguage;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeI18nLanguageListResponse
//

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLYouTubeI18nLanguageListResponse : GTLCollectionObject

// Etag of this resource.
@property (nonatomic, copy) NSString *ETag;

// Serialized EventId of the request which produced this response.
@property (nonatomic, copy) NSString *eventId;

// A list of supported i18n languages. In this map, the i18n language ID is the
// map key, and its value is the corresponding i18nLanguage resource.
@property (nonatomic, retain) NSArray *items;  // of GTLYouTubeI18nLanguage

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#i18nLanguageListResponse".
@property (nonatomic, copy) NSString *kind;

// The visitorId identifies the visitor.
@property (nonatomic, copy) NSString *visitorId;

@end

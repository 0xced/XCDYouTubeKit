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
//  GTLYouTubeLocalizedProperty.h
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
//   GTLYouTubeLocalizedProperty (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeLanguageTag;
@class GTLYouTubeLocalizedString;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLocalizedProperty
//

@interface GTLYouTubeLocalizedProperty : GTLObject

// Remapped to 'defaultProperty' to avoid language reserved word 'default'.
@property (nonatomic, copy) NSString *defaultProperty;

// The language of the default property.
@property (nonatomic, retain) GTLYouTubeLanguageTag *defaultLanguage;

@property (nonatomic, retain) NSArray *localized;  // of GTLYouTubeLocalizedString
@end

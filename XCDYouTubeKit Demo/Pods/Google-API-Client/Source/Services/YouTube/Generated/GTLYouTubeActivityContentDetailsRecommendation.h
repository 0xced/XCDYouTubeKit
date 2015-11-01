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
//  GTLYouTubeActivityContentDetailsRecommendation.h
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
//   GTLYouTubeActivityContentDetailsRecommendation (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeResourceId;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeActivityContentDetailsRecommendation
//

// Information that identifies the recommended resource.

@interface GTLYouTubeActivityContentDetailsRecommendation : GTLObject

// The reason that the resource is recommended to the user.
@property (copy) NSString *reason;

// The resourceId object contains information that identifies the recommended
// resource.
@property (retain) GTLYouTubeResourceId *resourceId;

// The seedResourceId object contains information about the resource that caused
// the recommendation.
@property (retain) GTLYouTubeResourceId *seedResourceId;

@end

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
//  GTLYouTubeInvideoTiming.h
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
//   GTLYouTubeInvideoTiming (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeInvideoTiming
//

// Describes a temporal position of a visual widget inside a video.

@interface GTLYouTubeInvideoTiming : GTLObject

// Defines the duration in milliseconds for which the promotion should be
// displayed. If missing, the client should use the default.
@property (nonatomic, retain) NSNumber *durationMs;  // unsignedLongLongValue

// Defines the time at which the promotion will appear. Depending on the value
// of type the value of the offsetMs field will represent a time offset from the
// start or from the end of the video, expressed in milliseconds.
@property (nonatomic, retain) NSNumber *offsetMs;  // unsignedLongLongValue

// Describes a timing type. If the value is offsetFromStart, then the offsetMs
// field represents an offset from the start of the video. If the value is
// offsetFromEnd, then the offsetMs field represents an offset from the end of
// the video.
@property (nonatomic, copy) NSString *type;

@end

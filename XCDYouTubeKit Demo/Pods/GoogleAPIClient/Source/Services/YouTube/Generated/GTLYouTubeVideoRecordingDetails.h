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
//  GTLYouTubeVideoRecordingDetails.h
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
//   GTLYouTubeVideoRecordingDetails (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeGeoPoint;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoRecordingDetails
//

// Recording information associated with the video.

@interface GTLYouTubeVideoRecordingDetails : GTLObject

// The geolocation information associated with the video.
@property (nonatomic, retain) GTLYouTubeGeoPoint *location;

// The text description of the location where the video was recorded.
@property (nonatomic, copy) NSString *locationDescription;

// The date and time when the video was recorded. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sssZ) format.
@property (nonatomic, retain) GTLDateTime *recordingDate;

@end

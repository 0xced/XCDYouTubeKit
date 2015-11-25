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
//  GTLYouTubeVideoStatus.h
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
//   GTLYouTubeVideoStatus (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoStatus
//

// Basic details about a video category, such as its localized title.

@interface GTLYouTubeVideoStatus : GTLObject

// This value indicates if the video can be embedded on another website.
@property (retain) NSNumber *embeddable;  // boolValue

// This value explains why a video failed to upload. This property is only
// present if the uploadStatus property indicates that the upload failed.
@property (copy) NSString *failureReason;

// The video's license.
@property (copy) NSString *license;

// The video's privacy status.
@property (copy) NSString *privacyStatus;

// This value indicates if the extended video statistics on the watch page can
// be viewed by everyone. Note that the view count, likes, etc will still be
// visible if this is disabled.
@property (retain) NSNumber *publicStatsViewable;  // boolValue

// The date and time when the video is scheduled to publish. It can be set only
// if the privacy status of the video is private. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (retain) GTLDateTime *publishAt;

// This value explains why YouTube rejected an uploaded video. This property is
// only present if the uploadStatus property indicates that the upload was
// rejected.
@property (copy) NSString *rejectionReason;

// The status of the uploaded video.
@property (copy) NSString *uploadStatus;

@end

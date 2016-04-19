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
//  GTLYouTubeVideoAbuseReport.h
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
//   GTLYouTubeVideoAbuseReport (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoAbuseReport
//

@interface GTLYouTubeVideoAbuseReport : GTLObject

// Additional comments regarding the abuse report.
@property (nonatomic, copy) NSString *comments;

// The language that the content was viewed in.
@property (nonatomic, copy) NSString *language;

// The high-level, or primary, reason that the content is abusive. The value is
// an abuse report reason ID.
@property (nonatomic, copy) NSString *reasonId;

// The specific, or secondary, reason that this content is abusive (if
// available). The value is an abuse report reason ID that is a valid secondary
// reason for the primary reason.
@property (nonatomic, copy) NSString *secondaryReasonId;

// The ID that YouTube uses to uniquely identify the video.
@property (nonatomic, copy) NSString *videoId;

@end

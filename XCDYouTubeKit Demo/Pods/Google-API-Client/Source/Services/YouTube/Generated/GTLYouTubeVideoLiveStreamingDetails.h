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
//  GTLYouTubeVideoLiveStreamingDetails.h
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
//   GTLYouTubeVideoLiveStreamingDetails (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoLiveStreamingDetails
//

// Details about the live streaming metadata.

@interface GTLYouTubeVideoLiveStreamingDetails : GTLObject

// The time that the broadcast actually ended. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format. This value will not be available until
// the broadcast is over.
@property (retain) GTLDateTime *actualEndTime;

// The time that the broadcast actually started. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format. This value will not be available until
// the broadcast begins.
@property (retain) GTLDateTime *actualStartTime;

// The number of viewers currently watching the broadcast. The property and its
// value will be present if the broadcast has current viewers and the broadcast
// owner has not hidden the viewcount for the video. Note that YouTube stops
// tracking the number of concurrent viewers for a broadcast when the broadcast
// ends. So, this property would not identify the number of viewers watching an
// archived video of a live broadcast that already ended.
@property (retain) NSNumber *concurrentViewers;  // unsignedLongLongValue

// The time that the broadcast is scheduled to end. The value is specified in
// ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format. If the value is empty or the
// property is not present, then the broadcast is scheduled to continue
// indefinitely.
@property (retain) GTLDateTime *scheduledEndTime;

// The time that the broadcast is scheduled to begin. The value is specified in
// ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (retain) GTLDateTime *scheduledStartTime;

@end

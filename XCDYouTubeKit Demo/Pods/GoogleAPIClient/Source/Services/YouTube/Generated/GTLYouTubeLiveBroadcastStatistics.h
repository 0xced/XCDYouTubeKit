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
//  GTLYouTubeLiveBroadcastStatistics.h
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
//   GTLYouTubeLiveBroadcastStatistics (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveBroadcastStatistics
//

// Statistics about the live broadcast. These represent a snapshot of the values
// at the time of the request. Statistics are only returned for live broadcasts.

@interface GTLYouTubeLiveBroadcastStatistics : GTLObject

// The number of viewers currently watching the broadcast. The property and its
// value will be present if the broadcast has current viewers and the broadcast
// owner has not hidden the viewcount for the video. Note that YouTube stops
// tracking the number of concurrent viewers for a broadcast when the broadcast
// ends. So, this property would not identify the number of viewers watching an
// archived video of a live broadcast that already ended.
@property (nonatomic, retain) NSNumber *concurrentViewers;  // unsignedLongLongValue

// The total number of live chat messages currently on the broadcast. The
// property and its value will be present if the broadcast is public, has the
// live chat feature enabled, and has at least one message. Note that this field
// will not be filled after the broadcast ends. So this property would not
// identify the number of chat messages for an archived video of a completed
// live broadcast.
@property (nonatomic, retain) NSNumber *totalChatCount;  // unsignedLongLongValue

@end

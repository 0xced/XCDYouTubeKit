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
//  GTLYouTubeMonitorStreamInfo.h
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
//   GTLYouTubeMonitorStreamInfo (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeMonitorStreamInfo
//

// Settings and Info of the monitor stream

@interface GTLYouTubeMonitorStreamInfo : GTLObject

// If you have set the enableMonitorStream property to true, then this property
// determines the length of the live broadcast delay.
@property (retain) NSNumber *broadcastStreamDelayMs;  // unsignedIntValue

// HTML code that embeds a player that plays the monitor stream.
@property (copy) NSString *embedHtml;

// This value determines whether the monitor stream is enabled for the
// broadcast. If the monitor stream is enabled, then YouTube will broadcast the
// event content on a special stream intended only for the broadcaster's
// consumption. The broadcaster can use the stream to review the event content
// and also to identify the optimal times to insert cuepoints.
// You need to set this value to true if you intend to have a broadcast delay
// for your event.
// Note: This property cannot be updated once the broadcast is in the testing or
// live state.
@property (retain) NSNumber *enableMonitorStream;  // boolValue

@end

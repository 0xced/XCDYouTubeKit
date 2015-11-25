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
//  GTLYouTubeChannelStatistics.h
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
//   GTLYouTubeChannelStatistics (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeChannelStatistics
//

// Statistics about a channel: number of subscribers, number of videos in the
// channel, etc.

@interface GTLYouTubeChannelStatistics : GTLObject

// The number of comments for the channel.
@property (retain) NSNumber *commentCount;  // unsignedLongLongValue

// Whether or not the number of subscribers is shown for this user.
@property (retain) NSNumber *hiddenSubscriberCount;  // boolValue

// The number of subscribers that the channel has.
@property (retain) NSNumber *subscriberCount;  // unsignedLongLongValue

// The number of videos uploaded to the channel.
@property (retain) NSNumber *videoCount;  // unsignedLongLongValue

// The number of times the channel has been viewed.
@property (retain) NSNumber *viewCount;  // unsignedLongLongValue

@end

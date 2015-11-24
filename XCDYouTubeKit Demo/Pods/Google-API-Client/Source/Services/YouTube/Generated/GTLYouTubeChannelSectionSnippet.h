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
//  GTLYouTubeChannelSectionSnippet.h
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
//   GTLYouTubeChannelSectionSnippet (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeChannelSectionSnippet
//

// Basic details about a channelsection, including title, style and position.

@interface GTLYouTubeChannelSectionSnippet : GTLObject

// The ID that YouTube uses to uniquely identify the channel that published the
// channelSection.
@property (copy) NSString *channelId;

// The position of the channelSection in the channel.
@property (retain) NSNumber *position;  // unsignedIntValue

// The style of the channelSection.
@property (copy) NSString *style;

// The channelSection's title for multiple_playlists and multiple_channels.
@property (copy) NSString *title;

// The type of the channelSection.
@property (copy) NSString *type;

@end

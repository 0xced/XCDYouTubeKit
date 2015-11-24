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
//  GTLYouTubeChannelConversionPings.h
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
//   GTLYouTubeChannelConversionPings (0 custom class methods, 1 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeChannelConversionPing;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeChannelConversionPings
//

// The conversionPings object encapsulates information about conversion pings
// that need to be respected by the channel.

@interface GTLYouTubeChannelConversionPings : GTLObject

// Pings that the app shall fire (authenticated by biscotti cookie). Each ping
// has a context, in which the app must fire the ping, and a url identifying the
// ping.
@property (retain) NSArray *pings;  // of GTLYouTubeChannelConversionPing

@end

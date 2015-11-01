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
//  GTLYouTubeCdnSettings.h
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
//   GTLYouTubeCdnSettings (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeIngestionInfo;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeCdnSettings
//

// Brief description of the live stream cdn settings.

@interface GTLYouTubeCdnSettings : GTLObject

// The format of the video stream that you are sending to Youtube.
@property (copy) NSString *format;

// The ingestionInfo object contains information that YouTube provides that you
// need to transmit your RTMP or HTTP stream to YouTube.
@property (retain) GTLYouTubeIngestionInfo *ingestionInfo;

// The method or protocol used to transmit the video stream.
@property (copy) NSString *ingestionType;

@end

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
//  GTLYouTubeIngestionInfo.h
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
//   GTLYouTubeIngestionInfo (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeIngestionInfo
//

// Describes information necessary for ingesting an RTMP or an HTTP stream.

@interface GTLYouTubeIngestionInfo : GTLObject

// The backup ingestion URL that you should use to stream video to YouTube. You
// have the option of simultaneously streaming the content that you are sending
// to the ingestionAddress to this URL.
@property (nonatomic, copy) NSString *backupIngestionAddress;

// The primary ingestion URL that you should use to stream video to YouTube. You
// must stream video to this URL.
// Depending on which application or tool you use to encode your video stream,
// you may need to enter the stream URL and stream name separately or you may
// need to concatenate them in the following format:
// STREAM_URL/STREAM_NAME
@property (nonatomic, copy) NSString *ingestionAddress;

// The HTTP or RTMP stream name that YouTube assigns to the video stream.
@property (nonatomic, copy) NSString *streamName;

@end

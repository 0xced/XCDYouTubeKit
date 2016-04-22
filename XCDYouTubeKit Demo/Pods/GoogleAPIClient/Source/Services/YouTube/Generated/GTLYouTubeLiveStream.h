/* Copyright (c) 2016 Google Inc.
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
//  GTLYouTubeLiveStream.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   YouTube Data API (youtube/v3)
// Description:
//   Supports core YouTube features, such as uploading videos, creating and
//   managing playlists, searching for content, and much more.
// Documentation:
//   https://developers.google.com/youtube/v3
// Classes:
//   GTLYouTubeLiveStream (0 custom class methods, 7 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeCdnSettings;
@class GTLYouTubeLiveStreamContentDetails;
@class GTLYouTubeLiveStreamSnippet;
@class GTLYouTubeLiveStreamStatus;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveStream
//

// A live stream describes a live ingestion point.

@interface GTLYouTubeLiveStream : GTLObject

// The cdn object defines the live stream's content delivery network (CDN)
// settings. These settings provide details about the manner in which you stream
// your content to YouTube.
@property (nonatomic, retain) GTLYouTubeCdnSettings *cdn;

// The content_details object contains information about the stream, including
// the closed captions ingestion URL.
@property (nonatomic, retain) GTLYouTubeLiveStreamContentDetails *contentDetails;

// Etag of this resource.
@property (nonatomic, copy) NSString *ETag;

// The ID that YouTube assigns to uniquely identify the stream.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#liveStream".
@property (nonatomic, copy) NSString *kind;

// The snippet object contains basic details about the stream, including its
// channel, title, and description.
@property (nonatomic, retain) GTLYouTubeLiveStreamSnippet *snippet;

// The status object contains information about live stream's status.
@property (nonatomic, retain) GTLYouTubeLiveStreamStatus *status;

@end

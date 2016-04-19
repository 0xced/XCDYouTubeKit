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
//  GTLYouTubeLiveStreamContentDetails.h
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
//   GTLYouTubeLiveStreamContentDetails (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveStreamContentDetails
//

// Detailed settings of a stream.

@interface GTLYouTubeLiveStreamContentDetails : GTLObject

// The ingestion URL where the closed captions of this stream are sent.
@property (nonatomic, copy) NSString *closedCaptionsIngestionUrl;

// Indicates whether the stream is reusable, which means that it can be bound to
// multiple broadcasts. It is common for broadcasters to reuse the same stream
// for many different broadcasts if those broadcasts occur at different times.
// If you set this value to false, then the stream will not be reusable, which
// means that it can only be bound to one broadcast. Non-reusable streams differ
// from reusable streams in the following ways:
// - A non-reusable stream can only be bound to one broadcast.
// - A non-reusable stream might be deleted by an automated process after the
// broadcast ends.
// - The liveStreams.list method does not list non-reusable streams if you call
// the method and set the mine parameter to true. The only way to use that
// method to retrieve the resource for a non-reusable stream is to use the id
// parameter to identify the stream.
@property (nonatomic, retain) NSNumber *isReusable;  // boolValue

@end

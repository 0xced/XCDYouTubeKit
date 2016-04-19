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
//  GTLYouTubeLiveStreamSnippet.h
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
//   GTLYouTubeLiveStreamSnippet (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveStreamSnippet
//

@interface GTLYouTubeLiveStreamSnippet : GTLObject

// The ID that YouTube uses to uniquely identify the channel that is
// transmitting the stream.
@property (nonatomic, copy) NSString *channelId;

// The stream's description. The value cannot be longer than 10000 characters.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

@property (nonatomic, retain) NSNumber *isDefaultStream;  // boolValue

// The date and time that the stream was created. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// The stream's title. The value must be between 1 and 128 characters long.
@property (nonatomic, copy) NSString *title;

@end

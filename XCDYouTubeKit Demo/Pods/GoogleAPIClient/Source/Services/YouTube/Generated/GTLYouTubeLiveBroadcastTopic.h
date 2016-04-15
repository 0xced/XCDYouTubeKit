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
//  GTLYouTubeLiveBroadcastTopic.h
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
//   GTLYouTubeLiveBroadcastTopic (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeLiveBroadcastTopicSnippet;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveBroadcastTopic
//

@interface GTLYouTubeLiveBroadcastTopic : GTLObject

// Information about the topic matched.
@property (nonatomic, retain) GTLYouTubeLiveBroadcastTopicSnippet *snippet;

// The type of the topic.
@property (nonatomic, copy) NSString *type;

// If this flag is set it means that we have not been able to match the topic
// title and type provided to a known entity.
@property (nonatomic, retain) NSNumber *unmatched;  // boolValue

@end

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
//  GTLYouTubeVideoTopicDetails.h
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
//   GTLYouTubeVideoTopicDetails (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoTopicDetails
//

// Freebase topic information related to the video.

@interface GTLYouTubeVideoTopicDetails : GTLObject

// Similar to topic_id, except that these topics are merely relevant to the
// video. These are topics that may be mentioned in, or appear in the video. You
// can retrieve information about each topic using Freebase Topic API.
@property (nonatomic, retain) NSArray *relevantTopicIds;  // of NSString

// A list of Freebase topic IDs that are centrally associated with the video.
// These are topics that are centrally featured in the video, and it can be said
// that the video is mainly about each of these. You can retrieve information
// about each topic using the Freebase Topic API.
@property (nonatomic, retain) NSArray *topicIds;  // of NSString

@end

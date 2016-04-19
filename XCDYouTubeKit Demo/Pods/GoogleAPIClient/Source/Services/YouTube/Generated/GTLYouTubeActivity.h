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
//  GTLYouTubeActivity.h
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
//   GTLYouTubeActivity (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeActivityContentDetails;
@class GTLYouTubeActivitySnippet;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeActivity
//

// An activity resource contains information about an action that a particular
// channel, or user, has taken on YouTube.The actions reported in activity feeds
// include rating a video, sharing a video, marking a video as a favorite,
// commenting on a video, uploading a video, and so forth. Each activity
// resource identifies the type of action, the channel associated with the
// action, and the resource(s) associated with the action, such as the video
// that was rated or uploaded.

@interface GTLYouTubeActivity : GTLObject

// The contentDetails object contains information about the content associated
// with the activity. For example, if the snippet.type value is videoRated, then
// the contentDetails object's content identifies the rated video.
@property (nonatomic, retain) GTLYouTubeActivityContentDetails *contentDetails;

// Etag of this resource.
@property (nonatomic, copy) NSString *ETag;

// The ID that YouTube uses to uniquely identify the activity.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#activity".
@property (nonatomic, copy) NSString *kind;

// The snippet object contains basic details about the activity, including the
// activity's type and group ID.
@property (nonatomic, retain) GTLYouTubeActivitySnippet *snippet;

@end

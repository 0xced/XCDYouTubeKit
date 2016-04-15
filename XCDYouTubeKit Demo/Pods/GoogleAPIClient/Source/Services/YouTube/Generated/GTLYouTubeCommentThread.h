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
//  GTLYouTubeCommentThread.h
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
//   GTLYouTubeCommentThread (0 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeCommentThreadReplies;
@class GTLYouTubeCommentThreadSnippet;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeCommentThread
//

// A comment thread represents information that applies to a top level comment
// and all its replies. It can also include the top level comment itself and
// some of the replies.

@interface GTLYouTubeCommentThread : GTLObject

// Etag of this resource.
@property (nonatomic, copy) NSString *ETag;

// The ID that YouTube uses to uniquely identify the comment thread.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#commentThread".
@property (nonatomic, copy) NSString *kind;

// The replies object contains a limited number of replies (if any) to the top
// level comment found in the snippet.
@property (nonatomic, retain) GTLYouTubeCommentThreadReplies *replies;

// The snippet object contains basic details about the comment thread and also
// the top level comment.
@property (nonatomic, retain) GTLYouTubeCommentThreadSnippet *snippet;

@end

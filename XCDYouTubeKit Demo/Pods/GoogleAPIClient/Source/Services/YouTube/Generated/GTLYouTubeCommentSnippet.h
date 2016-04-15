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
//  GTLYouTubeCommentSnippet.h
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
//   GTLYouTubeCommentSnippet (0 custom class methods, 16 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeCommentSnippet
//

// Basic details about a comment, such as its author and text.

@interface GTLYouTubeCommentSnippet : GTLObject

// The id of the author's YouTube channel, if any.
@property (nonatomic, retain) id authorChannelId;

// Link to the author's YouTube channel, if any.
@property (nonatomic, copy) NSString *authorChannelUrl;

// The name of the user who posted the comment.
@property (nonatomic, copy) NSString *authorDisplayName;

// Link to the author's Google+ profile, if any.
@property (nonatomic, copy) NSString *authorGoogleplusProfileUrl;

// The URL for the avatar of the user who posted the comment.
@property (nonatomic, copy) NSString *authorProfileImageUrl;

// Whether the current viewer can rate this comment.
@property (nonatomic, retain) NSNumber *canRate;  // boolValue

// The id of the corresponding YouTube channel. In case of a channel comment
// this is the channel the comment refers to. In case of a video comment it's
// the video's channel.
@property (nonatomic, copy) NSString *channelId;

// The total number of likes this comment has received.
@property (nonatomic, retain) NSNumber *likeCount;  // unsignedIntValue

// The comment's moderation status. Will not be set if the comments were
// requested through the id filter.
@property (nonatomic, copy) NSString *moderationStatus;

// The unique id of the parent comment, only set for replies.
@property (nonatomic, copy) NSString *parentId;

// The date and time when the comment was orignally published. The value is
// specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// The comment's text. The format is either plain text or HTML dependent on what
// has been requested. Even the plain text representation may differ from the
// text originally posted in that it may replace video links with video titles
// etc.
@property (nonatomic, copy) NSString *textDisplay;

// The comment's original raw text as initially posted or last updated. The
// original text will only be returned if it is accessible to the viewer, which
// is only guaranteed if the viewer is the comment's author.
@property (nonatomic, copy) NSString *textOriginal;

// The date and time when was last updated . The value is specified in ISO 8601
// (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *updatedAt;

// The ID of the video the comment refers to, if any.
@property (nonatomic, copy) NSString *videoId;

// The rating the viewer has given to this comment. For the time being this will
// never return RATE_TYPE_DISLIKE and instead return RATE_TYPE_NONE. This may
// change in the future.
@property (nonatomic, copy) NSString *viewerRating;

@end

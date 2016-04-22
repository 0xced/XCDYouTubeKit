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
//  GTLYouTubeLiveChatMessageAuthorDetails.h
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
//   GTLYouTubeLiveChatMessageAuthorDetails (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveChatMessageAuthorDetails
//

@interface GTLYouTubeLiveChatMessageAuthorDetails : GTLObject

// The YouTube channel ID.
@property (nonatomic, copy) NSString *channelId;

// The channel's URL.
@property (nonatomic, copy) NSString *channelUrl;

// The channel's display name.
@property (nonatomic, copy) NSString *displayName;

// Whether the author is a moderator of the live chat.
@property (nonatomic, retain) NSNumber *isChatModerator;  // boolValue

// Whether the author is the owner of the live chat.
@property (nonatomic, retain) NSNumber *isChatOwner;  // boolValue

// Whether the author is a sponsor of the live chat.
@property (nonatomic, retain) NSNumber *isChatSponsor;  // boolValue

// Whether the author's identity has been verified by YouTube.
@property (nonatomic, retain) NSNumber *isVerified;  // boolValue

// The channels's avatar URL.
@property (nonatomic, copy) NSString *profileImageUrl;

@end

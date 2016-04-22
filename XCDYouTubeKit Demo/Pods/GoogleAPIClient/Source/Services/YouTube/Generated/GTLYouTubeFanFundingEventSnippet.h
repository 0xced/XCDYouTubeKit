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
//  GTLYouTubeFanFundingEventSnippet.h
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
//   GTLYouTubeFanFundingEventSnippet (0 custom class methods, 7 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeChannelProfileDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeFanFundingEventSnippet
//

@interface GTLYouTubeFanFundingEventSnippet : GTLObject

// The amount of funding in micros of fund_currency. e.g., 1 is represented
@property (nonatomic, retain) NSNumber *amountMicros;  // unsignedLongLongValue

// Channel id where the funding event occurred.
@property (nonatomic, copy) NSString *channelId;

// The text contents of the comment left by the user.
@property (nonatomic, copy) NSString *commentText;

// The date and time when the funding occurred. The value is specified in ISO
// 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *createdAt;

// The currency in which the fund was made. ISO 4217.
@property (nonatomic, copy) NSString *currency;

// A rendered string that displays the fund amount and currency (e.g., "$1.00").
// The string is rendered for the given language.
@property (nonatomic, copy) NSString *displayString;

// Details about the supporter. Only filled if the event was made public by the
// user.
@property (nonatomic, retain) GTLYouTubeChannelProfileDetails *supporterDetails;

@end

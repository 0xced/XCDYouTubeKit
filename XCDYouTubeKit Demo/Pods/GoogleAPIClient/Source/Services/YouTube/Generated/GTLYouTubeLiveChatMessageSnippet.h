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
//  GTLYouTubeLiveChatMessageSnippet.h
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
//   GTLYouTubeLiveChatMessageSnippet (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeLiveChatFanFundingEventDetails;
@class GTLYouTubeLiveChatTextMessageDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveChatMessageSnippet
//

@interface GTLYouTubeLiveChatMessageSnippet : GTLObject

// The ID of the user that authored this message, this field is not always
// filled. textMessageEvent - the user that wrote the message fanFundingEvent -
// the user that funded the broadcast newSponsorEvent - the user that just
// became a sponsor
@property (nonatomic, copy) NSString *authorChannelId;

// Contains a string that can be displayed to the user. If this field is not
// present the message is silent, at the moment only messages of type TOMBSTONE
// and CHAT_ENDED_EVENT are silent.
@property (nonatomic, copy) NSString *displayMessage;

// Details about the funding event, this is only set if the type is
// 'fanFundingEvent'.
@property (nonatomic, retain) GTLYouTubeLiveChatFanFundingEventDetails *fanFundingEventDetails;

// Whether the message has display content that should be displayed to users.
@property (nonatomic, retain) NSNumber *hasDisplayContent;  // boolValue

@property (nonatomic, copy) NSString *liveChatId;

// The date and time when the message was orignally published. The value is
// specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// Details about the text message, this is only set if the type is
// 'textMessageEvent'.
@property (nonatomic, retain) GTLYouTubeLiveChatTextMessageDetails *textMessageDetails;

// The type of message, this will always be present, it determines the contents
// of the message as well as which fields will be present.
@property (nonatomic, copy) NSString *type;

@end

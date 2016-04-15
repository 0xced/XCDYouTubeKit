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
//  GTLYouTubeChannelSettings.h
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
//   GTLYouTubeChannelSettings (0 custom class methods, 14 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeChannelSettings
//

// Branding properties for the channel view.

@interface GTLYouTubeChannelSettings : GTLObject

// The country of the channel.
@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *defaultLanguage;

// Which content tab users should see when viewing the channel.
@property (nonatomic, copy) NSString *defaultTab;

// Specifies the channel description.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

// Title for the featured channels tab.
@property (nonatomic, copy) NSString *featuredChannelsTitle;

// The list of featured channels.
@property (nonatomic, retain) NSArray *featuredChannelsUrls;  // of NSString

// Lists keywords associated with the channel, comma-separated.
@property (nonatomic, copy) NSString *keywords;

// Whether user-submitted comments left on the channel page need to be approved
// by the channel owner to be publicly visible.
@property (nonatomic, retain) NSNumber *moderateComments;  // boolValue

// A prominent color that can be rendered on this channel page.
@property (nonatomic, copy) NSString *profileColor;

// Whether the tab to browse the videos should be displayed.
@property (nonatomic, retain) NSNumber *showBrowseView;  // boolValue

// Whether related channels should be proposed.
@property (nonatomic, retain) NSNumber *showRelatedChannels;  // boolValue

// Specifies the channel title.
@property (nonatomic, copy) NSString *title;

// The ID for a Google Analytics account to track and measure traffic to the
// channels.
@property (nonatomic, copy) NSString *trackingAnalyticsAccountId;

// The trailer of the channel, for users that are not subscribers.
@property (nonatomic, copy) NSString *unsubscribedTrailer;

@end

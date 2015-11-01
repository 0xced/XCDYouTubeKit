/* Copyright (c) 2013 Google Inc.
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
//  GTLYouTubeActivityContentDetailsPromotedItem.h
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
//   GTLYouTubeActivityContentDetailsPromotedItem (0 custom class methods, 10 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeActivityContentDetailsPromotedItem
//

// Details about a resource which is being promoted.

@interface GTLYouTubeActivityContentDetailsPromotedItem : GTLObject

// The URL the client should fetch to request a promoted item.
@property (copy) NSString *adTag;

// The URL the client should ping to indicate that the user clicked through on
// this promoted item.
@property (copy) NSString *clickTrackingUrl;

// The URL the client should ping to indicate that the user was shown this
// promoted item.
@property (copy) NSString *creativeViewUrl;

// The type of call-to-action, a message to the user indicating action that can
// be taken.
@property (copy) NSString *ctaType;

// The custom call-to-action button text. If specified, it will override the
// default button text for the cta_type.
@property (copy) NSString *customCtaButtonText;

// The text description to accompany the promoted item.
@property (copy) NSString *descriptionText;

// The URL the client should direct the user to, if the user chooses to visit
// the advertiser's website.
@property (copy) NSString *destinationUrl;

// The list of forecasting URLs. The client should ping all of these URLs when a
// promoted item is not available, to indicate that a promoted item could have
// been shown.
@property (retain) NSArray *forecastingUrl;  // of NSString

// The list of impression URLs. The client should ping all of these URLs to
// indicate that the user was shown this promoted item.
@property (retain) NSArray *impressionUrl;  // of NSString

// The ID that YouTube uses to uniquely identify the promoted video.
@property (copy) NSString *videoId;

@end

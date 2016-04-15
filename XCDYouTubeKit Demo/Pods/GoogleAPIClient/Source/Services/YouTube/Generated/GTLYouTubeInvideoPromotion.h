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
//  GTLYouTubeInvideoPromotion.h
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
//   GTLYouTubeInvideoPromotion (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeInvideoPosition;
@class GTLYouTubeInvideoTiming;
@class GTLYouTubePromotedItem;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeInvideoPromotion
//

// Describes an invideo promotion campaign consisting of multiple promoted
// items. A campaign belongs to a single channel_id.

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLYouTubeInvideoPromotion : GTLCollectionObject

// The default temporal position within the video where the promoted item will
// be displayed. Can be overriden by more specific timing in the item.
@property (nonatomic, retain) GTLYouTubeInvideoTiming *defaultTiming;

// List of promoted items in decreasing priority.
@property (nonatomic, retain) NSArray *items;  // of GTLYouTubePromotedItem

// The spatial position within the video where the promoted item will be
// displayed.
@property (nonatomic, retain) GTLYouTubeInvideoPosition *position;

// Indicates whether the channel's promotional campaign uses "smart timing."
// This feature attempts to show promotions at a point in the video when they
// are more likely to be clicked and less likely to disrupt the viewing
// experience. This feature also picks up a single promotion to show on each
// video.
@property (nonatomic, retain) NSNumber *useSmartTiming;  // boolValue

@end

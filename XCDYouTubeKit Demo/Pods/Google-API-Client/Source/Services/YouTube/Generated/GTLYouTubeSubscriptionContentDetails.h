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
//  GTLYouTubeSubscriptionContentDetails.h
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
//   GTLYouTubeSubscriptionContentDetails (0 custom class methods, 3 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeSubscriptionContentDetails
//

// Details about the content to witch a subscription refers.

@interface GTLYouTubeSubscriptionContentDetails : GTLObject

// The type of activity this subscription is for (only uploads, everything).
@property (copy) NSString *activityType;

// The number of new items in the subscription since its content was last read.
@property (retain) NSNumber *newItemCount NS_RETURNS_NOT_RETAINED;  // unsignedIntValue

// The approximate number of items that the subscription points to.
@property (retain) NSNumber *totalItemCount;  // unsignedIntValue

@end

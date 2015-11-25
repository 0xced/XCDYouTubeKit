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
//  GTLYouTubeSubscriptionSnippet.h
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
//   GTLYouTubeSubscriptionSnippet (0 custom class methods, 7 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeResourceId;
@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeSubscriptionSnippet
//

// Basic details about a subscription, including title, description and
// thumbnails of the subscribed item.

@interface GTLYouTubeSubscriptionSnippet : GTLObject

// The ID that YouTube uses to uniquely identify the subscriber's channel.
@property (copy) NSString *channelId;

// Channel title for the channel that the subscription belongs to.
@property (copy) NSString *channelTitle;

// The subscription's details.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (copy) NSString *descriptionProperty;

// The date and time that the subscription was created. The value is specified
// in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (retain) GTLDateTime *publishedAt;

// The id object contains information about the channel that the user subscribed
// to.
@property (retain) GTLYouTubeResourceId *resourceId;

// A map of thumbnail images associated with the video. For each object in the
// map, the key is the name of the thumbnail image, and the value is an object
// that contains other information about the thumbnail.
@property (retain) GTLYouTubeThumbnailDetails *thumbnails;

// The subscription's title.
@property (copy) NSString *title;

@end

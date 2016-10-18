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
//  GTLYouTubeLiveBroadcastSnippet.h
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
//   GTLYouTubeLiveBroadcastSnippet (0 custom class methods, 11 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeThumbnailDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveBroadcastSnippet
//

@interface GTLYouTubeLiveBroadcastSnippet : GTLObject

// The date and time that the broadcast actually ended. This information is only
// available once the broadcast's state is complete. The value is specified in
// ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *actualEndTime;

// The date and time that the broadcast actually started. This information is
// only available once the broadcast's state is live. The value is specified in
// ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *actualStartTime;

// The ID that YouTube uses to uniquely identify the channel that is publishing
// the broadcast.
@property (nonatomic, copy) NSString *channelId;

// The broadcast's description. As with the title, you can set this field by
// modifying the broadcast resource or by setting the description field of the
// corresponding video resource.
// Remapped to 'descriptionProperty' to avoid NSObject's 'description'.
@property (nonatomic, copy) NSString *descriptionProperty;

@property (nonatomic, retain) NSNumber *isDefaultBroadcast;  // boolValue

// The id of the live chat for this broadcast.
@property (nonatomic, copy) NSString *liveChatId;

// The date and time that the broadcast was added to YouTube's live broadcast
// schedule. The value is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *publishedAt;

// The date and time that the broadcast is scheduled to end. The value is
// specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *scheduledEndTime;

// The date and time that the broadcast is scheduled to start. The value is
// specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *scheduledStartTime;

// A map of thumbnail images associated with the broadcast. For each nested
// object in this object, the key is the name of the thumbnail image, and the
// value is an object that contains other information about the thumbnail.
@property (nonatomic, retain) GTLYouTubeThumbnailDetails *thumbnails;

// The broadcast's title. Note that the broadcast represents exactly one YouTube
// video. You can set this field by modifying the broadcast resource or by
// setting the title field of the corresponding video resource.
@property (nonatomic, copy) NSString *title;

@end

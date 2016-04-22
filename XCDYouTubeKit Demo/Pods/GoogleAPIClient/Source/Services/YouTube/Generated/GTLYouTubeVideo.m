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
//  GTLYouTubeVideo.m
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
//   GTLYouTubeVideo (0 custom class methods, 18 custom properties)
//   GTLYouTubeVideoLocalizations (0 custom class methods, 0 custom properties)

#import "GTLYouTubeVideo.h"

#import "GTLYouTubeVideoAgeGating.h"
#import "GTLYouTubeVideoContentDetails.h"
#import "GTLYouTubeVideoFileDetails.h"
#import "GTLYouTubeVideoLiveStreamingDetails.h"
#import "GTLYouTubeVideoLocalization.h"
#import "GTLYouTubeVideoMonetizationDetails.h"
#import "GTLYouTubeVideoPlayer.h"
#import "GTLYouTubeVideoProcessingDetails.h"
#import "GTLYouTubeVideoProjectDetails.h"
#import "GTLYouTubeVideoRecordingDetails.h"
#import "GTLYouTubeVideoSnippet.h"
#import "GTLYouTubeVideoStatistics.h"
#import "GTLYouTubeVideoStatus.h"
#import "GTLYouTubeVideoSuggestions.h"
#import "GTLYouTubeVideoTopicDetails.h"

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideo
//

@implementation GTLYouTubeVideo
@dynamic ageGating, contentDetails, ETag, fileDetails, identifier, kind,
         liveStreamingDetails, localizations, monetizationDetails, player,
         processingDetails, projectDetails, recordingDetails, snippet,
         statistics, status, suggestions, topicDetails;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map = @{
    @"ETag" : @"etag",
    @"identifier" : @"id"
  };
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"youtube#video"];
}

@end


// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoLocalizations
//

@implementation GTLYouTubeVideoLocalizations

+ (Class)classForAdditionalProperties {
  return [GTLYouTubeVideoLocalization class];
}

@end

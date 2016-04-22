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
//  GTLYouTubeSponsorListResponse.m
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
//   GTLYouTubeSponsorListResponse (0 custom class methods, 8 custom properties)

#import "GTLYouTubeSponsorListResponse.h"

#import "GTLYouTubePageInfo.h"
#import "GTLYouTubeSponsor.h"
#import "GTLYouTubeTokenPagination.h"

// ----------------------------------------------------------------------------
//
//   GTLYouTubeSponsorListResponse
//

@implementation GTLYouTubeSponsorListResponse
@dynamic ETag, eventId, items, kind, nextPageToken, pageInfo, tokenPagination,
         visitorId;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map = @{
    @"ETag" : @"etag"
  };
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map = @{
    @"items" : [GTLYouTubeSponsor class]
  };
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"youtube#sponsorListResponse"];
}

@end

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
//  GTLYouTubeGuideCategoryListResponse.m
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
//   GTLYouTubeGuideCategoryListResponse (0 custom class methods, 9 custom properties)

#import "GTLYouTubeGuideCategoryListResponse.h"

#import "GTLYouTubeGuideCategory.h"
#import "GTLYouTubePageInfo.h"
#import "GTLYouTubeTokenPagination.h"

// ----------------------------------------------------------------------------
//
//   GTLYouTubeGuideCategoryListResponse
//

@implementation GTLYouTubeGuideCategoryListResponse
@dynamic ETag, eventId, items, kind, nextPageToken, pageInfo, prevPageToken,
         tokenPagination, visitorId;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"etag"
                                forKey:@"ETag"];
  return map;
}

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLYouTubeGuideCategory class]
                                forKey:@"items"];
  return map;
}

+ (void)load {
  [self registerObjectClassForKind:@"youtube#guideCategoryListResponse"];
}

@end

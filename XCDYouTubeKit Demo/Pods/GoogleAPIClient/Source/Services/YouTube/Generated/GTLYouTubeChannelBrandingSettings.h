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
//  GTLYouTubeChannelBrandingSettings.h
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
//   GTLYouTubeChannelBrandingSettings (0 custom class methods, 4 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeChannelSettings;
@class GTLYouTubeImageSettings;
@class GTLYouTubePropertyValue;
@class GTLYouTubeWatchSettings;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeChannelBrandingSettings
//

// Branding properties of a YouTube channel.

@interface GTLYouTubeChannelBrandingSettings : GTLObject

// Branding properties for the channel view.
@property (nonatomic, retain) GTLYouTubeChannelSettings *channel;

// Additional experimental branding properties.
@property (nonatomic, retain) NSArray *hints;  // of GTLYouTubePropertyValue

// Branding properties for branding images.
@property (nonatomic, retain) GTLYouTubeImageSettings *image;

// Branding properties for the watch page.
@property (nonatomic, retain) GTLYouTubeWatchSettings *watch;

@end

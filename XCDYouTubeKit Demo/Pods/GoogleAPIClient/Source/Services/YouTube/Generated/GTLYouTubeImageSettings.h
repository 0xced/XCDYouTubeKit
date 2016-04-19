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
//  GTLYouTubeImageSettings.h
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
//   GTLYouTubeImageSettings (0 custom class methods, 22 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeLocalizedProperty;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeImageSettings
//

// Branding properties for images associated with the channel.

@interface GTLYouTubeImageSettings : GTLObject

// The URL for the background image shown on the video watch page. The image
// should be 1200px by 615px, with a maximum file size of 128k.
@property (nonatomic, retain) GTLYouTubeLocalizedProperty *backgroundImageUrl;

// This is used only in update requests; if it's set, we use this URL to
// generate all of the above banner URLs.
@property (nonatomic, copy) NSString *bannerExternalUrl;

// Banner image. Desktop size (1060x175).
@property (nonatomic, copy) NSString *bannerImageUrl;

// Banner image. Mobile size high resolution (1440x395).
@property (nonatomic, copy) NSString *bannerMobileExtraHdImageUrl;

// Banner image. Mobile size high resolution (1280x360).
@property (nonatomic, copy) NSString *bannerMobileHdImageUrl;

// Banner image. Mobile size (640x175).
@property (nonatomic, copy) NSString *bannerMobileImageUrl;

// Banner image. Mobile size low resolution (320x88).
@property (nonatomic, copy) NSString *bannerMobileLowImageUrl;

// Banner image. Mobile size medium/high resolution (960x263).
@property (nonatomic, copy) NSString *bannerMobileMediumHdImageUrl;

// Banner image. Tablet size extra high resolution (2560x424).
@property (nonatomic, copy) NSString *bannerTabletExtraHdImageUrl;

// Banner image. Tablet size high resolution (2276x377).
@property (nonatomic, copy) NSString *bannerTabletHdImageUrl;

// Banner image. Tablet size (1707x283).
@property (nonatomic, copy) NSString *bannerTabletImageUrl;

// Banner image. Tablet size low resolution (1138x188).
@property (nonatomic, copy) NSString *bannerTabletLowImageUrl;

// Banner image. TV size high resolution (1920x1080).
@property (nonatomic, copy) NSString *bannerTvHighImageUrl;

// Banner image. TV size extra high resolution (2120x1192).
@property (nonatomic, copy) NSString *bannerTvImageUrl;

// Banner image. TV size low resolution (854x480).
@property (nonatomic, copy) NSString *bannerTvLowImageUrl;

// Banner image. TV size medium resolution (1280x720).
@property (nonatomic, copy) NSString *bannerTvMediumImageUrl;

// The image map script for the large banner image.
@property (nonatomic, retain) GTLYouTubeLocalizedProperty *largeBrandedBannerImageImapScript;

// The URL for the 854px by 70px image that appears below the video player in
// the expanded video view of the video watch page.
@property (nonatomic, retain) GTLYouTubeLocalizedProperty *largeBrandedBannerImageUrl;

// The image map script for the small banner image.
@property (nonatomic, retain) GTLYouTubeLocalizedProperty *smallBrandedBannerImageImapScript;

// The URL for the 640px by 70px banner image that appears below the video
// player in the default view of the video watch page.
@property (nonatomic, retain) GTLYouTubeLocalizedProperty *smallBrandedBannerImageUrl;

// The URL for a 1px by 1px tracking pixel that can be used to collect
// statistics for views of the channel or video pages.
@property (nonatomic, copy) NSString *trackingImageUrl;

// The URL for the image that appears above the top-left corner of the video
// player. This is a 25-pixel-high image with a flexible width that cannot
// exceed 170 pixels.
@property (nonatomic, copy) NSString *watchIconImageUrl;

@end

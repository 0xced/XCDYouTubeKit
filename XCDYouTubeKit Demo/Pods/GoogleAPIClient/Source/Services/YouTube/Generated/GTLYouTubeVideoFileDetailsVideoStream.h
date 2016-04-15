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
//  GTLYouTubeVideoFileDetailsVideoStream.h
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
//   GTLYouTubeVideoFileDetailsVideoStream (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoFileDetailsVideoStream
//

// Information about a video stream.

@interface GTLYouTubeVideoFileDetailsVideoStream : GTLObject

// The video content's display aspect ratio, which specifies the aspect ratio in
// which the video should be displayed.
@property (nonatomic, retain) NSNumber *aspectRatio;  // doubleValue

// The video stream's bitrate, in bits per second.
@property (nonatomic, retain) NSNumber *bitrateBps;  // unsignedLongLongValue

// The video codec that the stream uses.
@property (nonatomic, copy) NSString *codec;

// The video stream's frame rate, in frames per second.
@property (nonatomic, retain) NSNumber *frameRateFps;  // doubleValue

// The encoded video content's height in pixels.
@property (nonatomic, retain) NSNumber *heightPixels;  // unsignedIntValue

// The amount that YouTube needs to rotate the original source content to
// properly display the video.
@property (nonatomic, copy) NSString *rotation;

// A value that uniquely identifies a video vendor. Typically, the value is a
// four-letter vendor code.
@property (nonatomic, copy) NSString *vendor;

// The encoded video content's width in pixels. You can calculate the video's
// encoding aspect ratio as width_pixels / height_pixels.
@property (nonatomic, retain) NSNumber *widthPixels;  // unsignedIntValue

@end

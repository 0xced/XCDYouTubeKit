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
//  GTLYouTubeVideoFileDetails.h
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
//   GTLYouTubeVideoFileDetails (0 custom class methods, 10 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeGeoPoint;
@class GTLYouTubeVideoFileDetailsAudioStream;
@class GTLYouTubeVideoFileDetailsVideoStream;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoFileDetails
//

// Describes original video file properties, including technical details about
// audio and video streams, but also metadata information like content length,
// digitization time, or geotagging information.

@interface GTLYouTubeVideoFileDetails : GTLObject

// A list of audio streams contained in the uploaded video file. Each item in
// the list contains detailed metadata about an audio stream.
@property (nonatomic, retain) NSArray *audioStreams;  // of GTLYouTubeVideoFileDetailsAudioStream

// The uploaded video file's combined (video and audio) bitrate in bits per
// second.
@property (nonatomic, retain) NSNumber *bitrateBps;  // unsignedLongLongValue

// The uploaded video file's container format.
@property (nonatomic, copy) NSString *container;

// The date and time when the uploaded video file was created. The value is
// specified in ISO 8601 format. Currently, the following ISO 8601 formats are
// supported:
// - Date only: YYYY-MM-DD
// - Naive time: YYYY-MM-DDTHH:MM:SS
// - Time with timezone: YYYY-MM-DDTHH:MM:SS+HH:MM
@property (nonatomic, copy) NSString *creationTime;

// The length of the uploaded video in milliseconds.
@property (nonatomic, retain) NSNumber *durationMs;  // unsignedLongLongValue

// The uploaded file's name. This field is present whether a video file or
// another type of file was uploaded.
@property (nonatomic, copy) NSString *fileName;

// The uploaded file's size in bytes. This field is present whether a video file
// or another type of file was uploaded.
@property (nonatomic, retain) NSNumber *fileSize;  // unsignedLongLongValue

// The uploaded file's type as detected by YouTube's video processing engine.
// Currently, YouTube only processes video files, but this field is present
// whether a video file or another type of file was uploaded.
@property (nonatomic, copy) NSString *fileType;

// Geographic coordinates that identify the place where the uploaded video was
// recorded. Coordinates are defined using WGS 84.
@property (nonatomic, retain) GTLYouTubeGeoPoint *recordingLocation;

// A list of video streams contained in the uploaded video file. Each item in
// the list contains detailed metadata about a video stream.
@property (nonatomic, retain) NSArray *videoStreams;  // of GTLYouTubeVideoFileDetailsVideoStream

@end

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
//  GTLYouTubeVideoProcessingDetails.h
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
//   GTLYouTubeVideoProcessingDetails (0 custom class methods, 8 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeVideoProcessingDetailsProcessingProgress;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoProcessingDetails
//

// Describes processing status and progress and availability of some other Video
// resource parts.

@interface GTLYouTubeVideoProcessingDetails : GTLObject

// This value indicates whether video editing suggestions, which might improve
// video quality or the playback experience, are available for the video. You
// can retrieve these suggestions by requesting the suggestions part in your
// videos.list() request.
@property (nonatomic, copy) NSString *editorSuggestionsAvailability;

// This value indicates whether file details are available for the uploaded
// video. You can retrieve a video's file details by requesting the fileDetails
// part in your videos.list() request.
@property (nonatomic, copy) NSString *fileDetailsAvailability;

// The reason that YouTube failed to process the video. This property will only
// have a value if the processingStatus property's value is failed.
@property (nonatomic, copy) NSString *processingFailureReason;

// This value indicates whether the video processing engine has generated
// suggestions that might improve YouTube's ability to process the the video,
// warnings that explain video processing problems, or errors that cause video
// processing problems. You can retrieve these suggestions by requesting the
// suggestions part in your videos.list() request.
@property (nonatomic, copy) NSString *processingIssuesAvailability;

// The processingProgress object contains information about the progress YouTube
// has made in processing the video. The values are really only relevant if the
// video's processing status is processing.
@property (nonatomic, retain) GTLYouTubeVideoProcessingDetailsProcessingProgress *processingProgress;

// The video's processing status. This value indicates whether YouTube was able
// to process the video or if the video is still being processed.
@property (nonatomic, copy) NSString *processingStatus;

// This value indicates whether keyword (tag) suggestions are available for the
// video. Tags can be added to a video's metadata to make it easier for other
// users to find the video. You can retrieve these suggestions by requesting the
// suggestions part in your videos.list() request.
@property (nonatomic, copy) NSString *tagSuggestionsAvailability;

// This value indicates whether thumbnail images have been generated for the
// video.
@property (nonatomic, copy) NSString *thumbnailsAvailability;

@end

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
//  GTLYouTubeVideo.h
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

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeVideoAgeGating;
@class GTLYouTubeVideoContentDetails;
@class GTLYouTubeVideoFileDetails;
@class GTLYouTubeVideoLiveStreamingDetails;
@class GTLYouTubeVideoLocalization;
@class GTLYouTubeVideoLocalizations;
@class GTLYouTubeVideoMonetizationDetails;
@class GTLYouTubeVideoPlayer;
@class GTLYouTubeVideoProcessingDetails;
@class GTLYouTubeVideoProjectDetails;
@class GTLYouTubeVideoRecordingDetails;
@class GTLYouTubeVideoSnippet;
@class GTLYouTubeVideoStatistics;
@class GTLYouTubeVideoStatus;
@class GTLYouTubeVideoSuggestions;
@class GTLYouTubeVideoTopicDetails;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideo
//

// A video resource represents a YouTube video.

@interface GTLYouTubeVideo : GTLObject

// Age restriction details related to a video. This data can only be retrieved
// by the video owner.
@property (nonatomic, retain) GTLYouTubeVideoAgeGating *ageGating;

// The contentDetails object contains information about the video content,
// including the length of the video and its aspect ratio.
@property (nonatomic, retain) GTLYouTubeVideoContentDetails *contentDetails;

// Etag of this resource.
@property (nonatomic, copy) NSString *ETag;

// The fileDetails object encapsulates information about the video file that was
// uploaded to YouTube, including the file's resolution, duration, audio and
// video codecs, stream bitrates, and more. This data can only be retrieved by
// the video owner.
@property (nonatomic, retain) GTLYouTubeVideoFileDetails *fileDetails;

// The ID that YouTube uses to uniquely identify the video.
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (nonatomic, copy) NSString *identifier;

// Identifies what kind of resource this is. Value: the fixed string
// "youtube#video".
@property (nonatomic, copy) NSString *kind;

// The liveStreamingDetails object contains metadata about a live video
// broadcast. The object will only be present in a video resource if the video
// is an upcoming, live, or completed live broadcast.
@property (nonatomic, retain) GTLYouTubeVideoLiveStreamingDetails *liveStreamingDetails;

// List with all localizations.
@property (nonatomic, retain) GTLYouTubeVideoLocalizations *localizations;

// The monetizationDetails object encapsulates information about the
// monetization status of the video.
@property (nonatomic, retain) GTLYouTubeVideoMonetizationDetails *monetizationDetails;

// The player object contains information that you would use to play the video
// in an embedded player.
@property (nonatomic, retain) GTLYouTubeVideoPlayer *player;

// The processingProgress object encapsulates information about YouTube's
// progress in processing the uploaded video file. The properties in the object
// identify the current processing status and an estimate of the time remaining
// until YouTube finishes processing the video. This part also indicates whether
// different types of data or content, such as file details or thumbnail images,
// are available for the video.
// The processingProgress object is designed to be polled so that the video
// uploaded can track the progress that YouTube has made in processing the
// uploaded video file. This data can only be retrieved by the video owner.
@property (nonatomic, retain) GTLYouTubeVideoProcessingDetails *processingDetails;

// The projectDetails object contains information about the project specific
// video metadata.
@property (nonatomic, retain) GTLYouTubeVideoProjectDetails *projectDetails;

// The recordingDetails object encapsulates information about the location, date
// and address where the video was recorded.
@property (nonatomic, retain) GTLYouTubeVideoRecordingDetails *recordingDetails;

// The snippet object contains basic details about the video, such as its title,
// description, and category.
@property (nonatomic, retain) GTLYouTubeVideoSnippet *snippet;

// The statistics object contains statistics about the video.
@property (nonatomic, retain) GTLYouTubeVideoStatistics *statistics;

// The status object contains information about the video's uploading,
// processing, and privacy statuses.
@property (nonatomic, retain) GTLYouTubeVideoStatus *status;

// The suggestions object encapsulates suggestions that identify opportunities
// to improve the video quality or the metadata for the uploaded video. This
// data can only be retrieved by the video owner.
@property (nonatomic, retain) GTLYouTubeVideoSuggestions *suggestions;

// The topicDetails object encapsulates information about Freebase topics
// associated with the video.
@property (nonatomic, retain) GTLYouTubeVideoTopicDetails *topicDetails;

@end


// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoLocalizations
//

@interface GTLYouTubeVideoLocalizations : GTLObject
// This object is documented as having more properties that are
// GTLYouTubeVideoLocalization. Use -additionalJSONKeys and
// -additionalPropertyForName: to get the list of properties and then fetch
// them; or -additionalProperties to fetch them all at once.
@end

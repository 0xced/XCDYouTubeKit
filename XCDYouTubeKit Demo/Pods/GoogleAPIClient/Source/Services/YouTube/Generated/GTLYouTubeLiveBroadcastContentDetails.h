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
//  GTLYouTubeLiveBroadcastContentDetails.h
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
//   GTLYouTubeLiveBroadcastContentDetails (0 custom class methods, 12 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLYouTubeMonitorStreamInfo;

// ----------------------------------------------------------------------------
//
//   GTLYouTubeLiveBroadcastContentDetails
//

// Detailed settings of a broadcast.

@interface GTLYouTubeLiveBroadcastContentDetails : GTLObject

// This value uniquely identifies the live stream bound to the broadcast.
@property (nonatomic, copy) NSString *boundStreamId;

// The date and time that the live stream referenced by boundStreamId was last
// updated.
@property (nonatomic, retain) GTLDateTime *boundStreamLastUpdateTimeMs;

@property (nonatomic, copy) NSString *closedCaptionsType;

// This setting indicates whether HTTP POST closed captioning is enabled for
// this broadcast. The ingestion URL of the closed captions is returned through
// the liveStreams API. This is mutually exclusive with using the
// closed_captions_type property, and is equivalent to setting
// closed_captions_type to CLOSED_CAPTIONS_HTTP_POST.
@property (nonatomic, retain) NSNumber *enableClosedCaptions;  // boolValue

// This setting indicates whether YouTube should enable content encryption for
// the broadcast.
@property (nonatomic, retain) NSNumber *enableContentEncryption;  // boolValue

// This setting determines whether viewers can access DVR controls while
// watching the video. DVR controls enable the viewer to control the video
// playback experience by pausing, rewinding, or fast forwarding content. The
// default value for this property is true.
// Important: You must set the value to true and also set the enableArchive
// property's value to true if you want to make playback available immediately
// after the broadcast ends.
@property (nonatomic, retain) NSNumber *enableDvr;  // boolValue

// This setting indicates whether the broadcast video can be played in an
// embedded player. If you choose to archive the video (using the enableArchive
// property), this setting will also apply to the archived video.
@property (nonatomic, retain) NSNumber *enableEmbed;  // boolValue

// Indicates whether this broadcast has low latency enabled.
@property (nonatomic, retain) NSNumber *enableLowLatency;  // boolValue

// The monitorStream object contains information about the monitor stream, which
// the broadcaster can use to review the event content before the broadcast
// stream is shown publicly.
@property (nonatomic, retain) GTLYouTubeMonitorStreamInfo *monitorStream;

// The projection format of this broadcast. This defaults to rectangular.
@property (nonatomic, copy) NSString *projection;

// Automatically start recording after the event goes live. The default value
// for this property is true.
// Important: You must also set the enableDvr property's value to true if you
// want the playback to be available immediately after the broadcast ends. If
// you set this property's value to true but do not also set the enableDvr
// property to true, there may be a delay of around one day before the archived
// video will be available for playback.
@property (nonatomic, retain) NSNumber *recordFromStart;  // boolValue

// This setting indicates whether the broadcast should automatically begin with
// an in-stream slate when you update the broadcast's status to live. After
// updating the status, you then need to send a liveCuepoints.insert request
// that sets the cuepoint's eventState to end to remove the in-stream slate and
// make your broadcast stream visible to viewers.
@property (nonatomic, retain) NSNumber *startWithSlate;  // boolValue

@end

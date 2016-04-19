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
//  GTLYouTubeCaptionSnippet.h
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
//   GTLYouTubeCaptionSnippet (0 custom class methods, 13 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeCaptionSnippet
//

// Basic details about a caption track, such as its language and name.

@interface GTLYouTubeCaptionSnippet : GTLObject

// The type of audio track associated with the caption track.
@property (nonatomic, copy) NSString *audioTrackType;

// The reason that YouTube failed to process the caption track. This property is
// only present if the state property's value is failed.
@property (nonatomic, copy) NSString *failureReason;

// Indicates whether YouTube synchronized the caption track to the audio track
// in the video. The value will be true if a sync was explicitly requested when
// the caption track was uploaded. For example, when calling the captions.insert
// or captions.update methods, you can set the sync parameter to true to
// instruct YouTube to sync the uploaded track to the video. If the value is
// false, YouTube uses the time codes in the uploaded caption track to determine
// when to display captions.
@property (nonatomic, retain) NSNumber *isAutoSynced;  // boolValue

// Indicates whether the track contains closed captions for the deaf and hard of
// hearing. The default value is false.
@property (nonatomic, retain) NSNumber *isCC;  // boolValue

// Indicates whether the caption track is a draft. If the value is true, then
// the track is not publicly visible. The default value is false.
@property (nonatomic, retain) NSNumber *isDraft;  // boolValue

// Indicates whether caption track is formatted for "easy reader," meaning it is
// at a third-grade level for language learners. The default value is false.
@property (nonatomic, retain) NSNumber *isEasyReader;  // boolValue

// Indicates whether the caption track uses large text for the vision-impaired.
// The default value is false.
@property (nonatomic, retain) NSNumber *isLarge;  // boolValue

// The language of the caption track. The property value is a BCP-47 language
// tag.
@property (nonatomic, copy) NSString *language;

// The date and time when the caption track was last updated. The value is
// specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
@property (nonatomic, retain) GTLDateTime *lastUpdated;

// The name of the caption track. The name is intended to be visible to the user
// as an option during playback.
@property (nonatomic, copy) NSString *name;

// The caption track's status.
@property (nonatomic, copy) NSString *status;

// The caption track's type.
@property (nonatomic, copy) NSString *trackKind;

// The ID that YouTube uses to uniquely identify the video associated with the
// caption track.
@property (nonatomic, copy) NSString *videoId;

@end

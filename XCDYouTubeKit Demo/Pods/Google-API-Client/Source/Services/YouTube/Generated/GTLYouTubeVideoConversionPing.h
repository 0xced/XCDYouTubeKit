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
//  GTLYouTubeVideoConversionPing.h
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
//   GTLYouTubeVideoConversionPing (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

// ----------------------------------------------------------------------------
//
//   GTLYouTubeVideoConversionPing
//

@interface GTLYouTubeVideoConversionPing : GTLObject

// Defines the context of the ping.
@property (copy) NSString *context;

// The url (without the schema) that the app shall send the ping to. It's at
// caller's descretion to decide which schema to use (http vs https) Example of
// a returned url: //googleads.g.doubleclick.net/pagead/
// viewthroughconversion/962985656/?data=path%3DtHe_path%3Btype%3D
// like%3Butuid%3DGISQtTNGYqaYl4sKxoVvKA%3Bytvid%3DUrIaJUvIQDg&labe=default The
// caller must append biscotti authentication (ms param in case of mobile, for
// example) to this ping.
@property (copy) NSString *conversionUrl;

@end

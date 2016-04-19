/* Copyright (c) 2011 Google Inc.
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
//  GTLJSONParser.h
//

// This class was for use with OS X 10.6 and iOS 4, prior to the availability of
// NSJSONSerialization.  It's still present for compatibility with code using it,
// but code should no longer use this class.

#import <Foundation/Foundation.h>

#import "GTLDefines.h"

@interface GTLJSONParser : NSObject
+ (NSString*)stringWithObject:(id)value
                humanReadable:(BOOL)humanReadable
                        error:(NSError**)error;

+ (NSData *)dataWithObject:(id)obj
             humanReadable:(BOOL)humanReadable
                     error:(NSError**)error;

+ (id)objectWithString:(NSString *)jsonStr
                 error:(NSError **)error;

+ (id)objectWithData:(NSData *)jsonData
               error:(NSError **)error;
@end

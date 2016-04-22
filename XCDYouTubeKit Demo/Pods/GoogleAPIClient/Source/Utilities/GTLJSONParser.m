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
//  GTLJSONParser.m
//

#import "GTLJSONParser.h"

static void GTLJSONParserLogDeprecationWarning() {
#if DEBUG
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSLog(@"WARNING: GTLJSONParser is deprecated; use NSJSONSerialization instead.");
  });
#endif
}

@implementation GTLJSONParser

+ (NSString *)stringWithObject:(id)obj
                 humanReadable:(BOOL)humanReadable
                         error:(NSError **)error {
  NSData *data = [self dataWithObject:obj
                        humanReadable:humanReadable
                                error:error];
  if (data) {
    NSString *jsonStr = [[[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding] autorelease];
    return jsonStr;
  }
  return nil;
}

+ (NSData *)dataWithObject:(id)obj
             humanReadable:(BOOL)humanReadable
                     error:(NSError **)error {
  GTLJSONParserLogDeprecationWarning();

  if (obj == nil) return nil;

  const NSUInteger kOpts = humanReadable ? (1UL << 0) : 0; // NSJSONWritingPrettyPrinted

  NSData *data = [NSJSONSerialization dataWithJSONObject:obj
                                                 options:kOpts
                                                   error:error];
  return data;
}

+ (id)objectWithString:(NSString *)jsonStr
                 error:(NSError **)error {
  GTLJSONParserLogDeprecationWarning();

  NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
  return [self objectWithData:data
                        error:error];
}

+ (id)objectWithData:(NSData *)jsonData
               error:(NSError **)error {
  GTLJSONParserLogDeprecationWarning();

  NSMutableDictionary *obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers
                                                               error:error];
  return obj;
}

@end

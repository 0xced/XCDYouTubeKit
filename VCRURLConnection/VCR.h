//
// VCR.h
//
// Copyright (c) 2012 Dustin Barker
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

/**
 * `VCR` records and replays HTTP interactions.
 
 # Recording
 
     [VCR start];
 
     NSString *path = @"http://example.com/example";
     NSURL *url = [NSURL URLWithString:path];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [NSURLConnection connectionWithRequest:request delegate:self];
 
     // NSURLConnection makes a real network request and VCRURLConnection
     // will record the request/response pair.
 
     NSString *path = [VCR save:@"/path/to/cassette.json"]; // copy the output file into your project
 
 # Replaying

     NSURL *cassetteURL = [NSURL fileURLWithPath:@"/path/to/cassette.json"];
     [VCR loadCassetteWithContentsOfURL:cassetteURL];
     [VCR start];
 
     // request an HTTP interaction that was recorded to cassette.json
     NSString *path = @"http://example.com/example";
     NSURL *url = [NSURL URLWithString:path];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [NSURLConnection connectionWithRequest:request delegate:self];
 
     // The cassette has a recording for this request, so no network request
     // is made. Instead NSURLConnectionDelegate methods are called with the
     // previously recorded response.
 
 */
@class VCRCassette;

@interface VCR : NSObject

/**
 Load all recorded HTTP interactions from cassette JSON file at `url`
 */
+ (void)loadCassetteWithContentsOfURL:(NSURL *)url;

/**
 The current cassette that all HTTP interactions are record to / replayed from
 */
+ (VCRCassette *)cassette;

/**
 Enable/disable recording of responses
 */
+ (void)setRecording:(BOOL)recording;

/**
 Returns YES if recording is enabled
 */
+ (BOOL)isRecording;

/**
 Enable/disable replaying of responses
 */
+ (void)setReplaying:(BOOL)replaying;

/**
 Returns YES if replaying is enabled
 */
+ (BOOL)isReplaying;

/**
 Begin recording or replaying HTTP interactions
 */
+ (void)start;

/**
 Stop recording or replaying HTTP interactions
 */
+ (void)stop;

/**
 Write recorded HTTP interactions to a JSON file
 
 @param path the output path
 */
+ (void)save:(NSString *)path;

@end

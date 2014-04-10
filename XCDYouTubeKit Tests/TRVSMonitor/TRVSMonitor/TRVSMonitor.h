//
//  TRVSXCTestAsync.h
//  TRVSXCTestAsyncExample
//
//  Created by Travis Jeffery on 10/11/13.
//  Copyright (c) 2013 Travis Jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TRVSMonitor;

typedef void (^TRVSMonitorHandler)(TRVSMonitor *monitor);

/**
 *  `TRVSMonitor` is a synchronization construct to make asynchronous testing simple. A `TRVSMonitor` is initialized with a signal count and can wait until it has been signalled its signal count.
 */
@interface TRVSMonitor : NSObject

/**
 *  Creates and returns a `TRVSMonitor` with signal count of 1.
 */
+ (instancetype)monitor;

/**
 *  Initializes and returns a `TRVSMonitor` with signal count of 1.
 */
- (instancetype)init;

/**
 *  Initializes and returns a `TRVSMonitor` with the specified expected signal count.
 *
 *  This is the designated initializer.
 *
 *  @param expectedSignalCount The number of times the `TRVSMonitor` needs to be signalled before it will stop waiting.
 *
 *  @return The newly-initialized monitor.
 */
- (instancetype)initWithExpectedSignalCount:(NSInteger)expectedSignalCount;

/**
 *  Prevents following statements from executing until the `TRVSMonitor` is signalled its expected signal count.
 *
 *  @return YES
 */
- (BOOL)wait;

/**
 *  Will timeout and continue executing after the specified time interval.
 *
 *  @param timeout The time interval that the `TRVSMonitor` will timeout after.
 *
 *  @return NO if the `TRVSMonitor` timed out, YES otherwise.
 *
 *  @see wait
 */
- (BOOL)waitWithTimeout:(NSTimeInterval)timeout;

/**
 *  Will continually execute the specified block in-between short time intervals.
 *
 *  @param handler A block object to be executed in-between short time intervals.
 *
 *  @return YES
 *
 *  @see wait
 */
- (BOOL)waitWithSignalHandler:(TRVSMonitorHandler)handler;

/**
 *  @see wait
 *  @see waitWithTimeout:
 *  @see waitWIthSignalHandler:
 */
- (BOOL)waitWithTimeout:(NSTimeInterval)timeout signalHandler:(TRVSMonitorHandler)handler;

/**
 *  What you message the `TRVSMonitor` as many times as the number of its expected signal count. Typically is called in an asynchronously executing block.
 */
- (void)signal;

@end

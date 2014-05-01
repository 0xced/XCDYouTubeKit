//
//  TRVSXCTestAsync.m
//  TRVSXCTestAsyncExample
//
//  Created by Travis Jeffery on 10/11/13.
//  Copyright (c) 2013 Travis Jeffery. All rights reserved.
//

#import "TRVSMonitor.h"

@interface TRVSMonitor ()

@property(nonatomic) NSInteger signalsRemaining;
@property(nonatomic) NSInteger expectedSignalCount;

@end

@implementation TRVSMonitor

+ (instancetype)monitor {
  return [[self alloc] init];
}

- (instancetype)init {
  return [self initWithExpectedSignalCount:1];
}

- (instancetype)initWithExpectedSignalCount:(NSInteger)expectedSignalCount {
  self = [super init];
  
  if (self) {
    self.expectedSignalCount = expectedSignalCount;
    [self reset];
  }
  
  return self;
}

- (BOOL)wait {
  return [self waitWithTimeout:0.0];
}

- (BOOL)waitWithSignalHandler:(TRVSMonitorHandler)handler {
  return [self waitWithTimeout:0.0 signalHandler:handler];
}

- (BOOL)waitWithTimeout:(NSTimeInterval)timeout {
  return [self waitWithTimeout:timeout signalHandler:nil];
}

- (BOOL)waitWithTimeout:(NSTimeInterval)timeout
          signalHandler:(TRVSMonitorHandler)handler {
  NSDate *start = [NSDate date];

  while (self.signalsRemaining > 0) {
    [[NSRunLoop currentRunLoop]
        runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.001]];

    if ([self didTimeOut:timeout fromStartDate:start]) {
      [self reset];
      
      return NO;
    }

    if (handler)
      handler(self);
  }

  [self reset];

  return YES;
}

- (void)signal {
  self.signalsRemaining -= 1;
}

#pragma mark - Private

- (void)reset {
  self.signalsRemaining = self.expectedSignalCount;
}

- (BOOL)didTimeOut:(NSTimeInterval)timeout fromStartDate:(NSDate *)startDate {
  return (timeout > 0.0 && [[NSDate date] timeIntervalSinceDate:startDate] >
                               timeout);
}

@end

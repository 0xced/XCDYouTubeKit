## About

[![Platform](https://img.shields.io/cocoapods/p/XCDLumberjackNSLogger.svg?style=flat)](http://cocoadocs.org/docsets/XCDLumberjackNSLogger/)
[![Pod Version](https://img.shields.io/cocoapods/v/XCDLumberjackNSLogger.svg?style=flat)](http://cocoadocs.org/docsets/XCDLumberjackNSLogger/)
[![License](https://img.shields.io/cocoapods/l/XCDLumberjackNSLogger.svg?style=flat)](LICENSE)

**XCDLumberjackNSLogger** is a [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) logger which sends logs to [NSLogger](https://github.com/fpillet/NSLogger).

## Requirements

- Runs on iOS 5.0 and later
- Runs on OS X 10.7 and later

## Installation

XCDLumberjackNSLogger is available through CocoaPods.

```ruby
pod "XCDLumberjackNSLogger", "~> 1.0.0"
```

## Usage

XCDLumberjackNSLogger is [fully documented](http://cocoadocs.org/docsets/XCDLumberjackNSLogger/).

#### Simply send logs to NSLogger

```objc
[DDLog addLogger:[XCDLumberjackNSLogger new]];
```

#### Configuring a bonjour service name

```objc
NSString *bonjourServiceName = [[[NSProcessInfo processInfo] environment] objectForKey:@"NSLOGGER_BONJOUR_SERVICE_NAME"];
[DDLog addLogger:[[XCDLumberjackNSLogger alloc] initWithBonjourServiceName:bonjourServiceName]];
```

#### Translating contexts to tags

```objc
XCDLumberjackNSLogger *logger = [XCDLumberjackNSLogger new];
logger.tags = @{ @80 : @"CocoaHTTPServer", @((NSInteger)0xced70676) : @"XCDYouTubeKit" };
[DDLog addLogger:logger];
```

#### Configuring a viewer host

```objc
XCDLumberjackNSLogger *logger = [XCDLumberjackNSLogger new];
LoggerSetViewerHost(logger.logger, CFSTR("10.0.1.7"), 50000);
[DDLog addLogger:logger];
```

## Contact

Cédric Luthi

- http://github.com/0xced
- http://twitter.com/0xced

## License

XCDLumberjackNSLogger is available under the MIT license. See the [LICENSE](LICENSE) file for more information.

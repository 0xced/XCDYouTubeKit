# TRVSMonitor

A synchronization construct with the ability to wait until signalled that a condition has been met.

Able to use with any testing framework, including XCTest, SenTestingKit, expecta.

[Why 'Monitor'](http://en.wikipedia.org/wiki/Monitor_%28synchronization%29).

## Example

``` objc
@interface APIClientTests : XCTestCase
@property (nonatomic, strong, readwrite) NSURLSession *URLSession;
@end

@implementation APIClientTests

- (void)setUp {
    self.URLSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (void)testAPIEndpoint {
    __block NSDictionary *JSON = nil;
    TRVSMonitor *monitor = [TRVSMonitor monitor];

    [[self.URLSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8000"]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        [monitor signal];
    }] resume];

    [monitor wait];

    XCTAssert(JSON);
    XCTAssertEqualObjects(@"1", JSON[@"id"]);
    XCTAssertEqualObjects(@"travis jeffery", JSON[@"name"]);
}

- (void)testAPIEndpoints {
    __block NSDictionary *personJSON, *twitterJSON;
    TRVSMonitor *monitor = [[TRVSMonitor alloc] initWithExpectedSignalCount:2];

    NSURL *baseURL = [NSURL URLWithString:@"http://127.0.0.1:8000"];
    [[self.URLSession dataTaskWithRequest:[NSURLRequest requestWithURL:baseURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        personJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        [self.URLSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:personJSON[@"id"] relativeToURL:baseURL]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            twitterJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            [monitor signal];
        }];
        [monitor signal];
    }] resume];

    [monitor wait];

    XCTAssert(personJSON);
    XCTAssert(twitterJSON);
    XCTAssertEqualObjects(@"travis jeffery", personJSON[@"name"]);
    XCTAssertEqualObjects(@"travisjeffery", twitterJSON[@"user_name"]);
}

@end
```

Likely worth seeing real uses in [TRVSEventSource](http://github.com/travisjeffery/TRVSEventSource)'s tests too.

## Author

[Travis Jeffery](http://twitter.com/travisjeffery)
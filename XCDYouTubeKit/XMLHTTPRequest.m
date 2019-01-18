#import "XMLHTTPRequest.h"


@implementation XMLHttpRequest {
    NSURLSession *_urlSession;
    NSString *_httpMethod;
    NSURL *_url;
    bool _async;
    NSMutableDictionary *_requestHeaders;
    NSDictionary *_responseHeaders;
};

@synthesize response;
@synthesize responseText;
@synthesize responseType;
@synthesize onreadystatechange;
@synthesize readyState;
@synthesize onload;
@synthesize onerror;
@synthesize status;
@synthesize statusText;


- (instancetype)init {
    return [self initWithURLSession:[NSURLSession sharedSession]];
}


- (instancetype)initWithURLSession:(NSURLSession *)urlSession {
	if ((self = [super init])) {
        _urlSession = urlSession;
        self.readyState = @(XMLHttpRequestUNSENT);
        _requestHeaders = [NSMutableDictionary new];
    }
    return self;
}

- (void)extend:(id)jsContext {

    // Simulate the constructor.
    jsContext[@"XMLHttpRequest"] = ^{
        return self;
    };
    jsContext[@"XMLHttpRequest"][@"UNSENT"] = @(XMLHttpRequestUNSENT);
    jsContext[@"XMLHttpRequest"][@"OPENED"] = @(XMLHttpRequestOPENED);
    jsContext[@"XMLHttpRequest"][@"LOADING"] = @(XMLHttpRequestLOADING);
    jsContext[@"XMLHttpRequest"][@"HEADERS"] = @(XMLHttpRequestHEADERS);
    jsContext[@"XMLHttpRequest"][@"DONE"] = @(XMLHttpRequestDONE);

}

- (void)open:(NSString *)httpMethod :(NSString *)url :(bool)async {
    // TODO should throw an error if called with wrong arguments
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
    _httpMethod = httpMethod;
    _url = [NSURL URLWithString:url];
    _async = async;
    self.readyState = @(XMLHttpRequestOPENED);
#pragma clang diagnostic pop
}

- (void)send:(id)data {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wshadow-ivar"
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    for (NSString *name in _requestHeaders) {
        [request setValue:_requestHeaders[name] forHTTPHeaderField:name];
    }
    if ([(NSObject *)data isKindOfClass:[NSString class]]) {
        request.HTTPBody = [((NSString *) data) dataUsingEncoding:NSUTF8StringEncoding];
    }
    [request setHTTPMethod:_httpMethod];

    __block __weak XMLHttpRequest *weakSelf = self;

    id completionHandler = ^(NSData *receivedData, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        weakSelf.readyState = @(XMLHttpRequestDONE); // TODO
        weakSelf.status = @(httpResponse.statusCode);
        weakSelf.statusText = [NSString stringWithFormat:@"%@",@(httpResponse.statusCode)];
        weakSelf.responseText = [[NSString alloc] initWithData:receivedData
                                                  encoding:NSUTF8StringEncoding];

        weakSelf.responseType = @"";
        weakSelf.response = weakSelf.responseText;
        
        [weakSelf setAllResponseHeaders:[httpResponse allHeaderFields]];
        if (weakSelf.onreadystatechange != nil) {
            [weakSelf.onreadystatechange callWithArguments:@[]];
        }
    };
    NSURLSessionDataTask *task = [_urlSession dataTaskWithRequest:request
                                                completionHandler:completionHandler];
    [task resume];
	
	#pragma clang diagnostic pop
}

- (void)setRequestHeader:(NSString *)name :(NSString *)value {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
    _requestHeaders[name] = value;
#pragma clang diagnostic pop
}

- (NSString *)getAllResponseHeaders {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
#pragma clang diagnostic ignored "-Wnullable-to-nonnull-conversion"
    NSMutableString *responseHeaders = [NSMutableString new];
    for (NSString *key in _responseHeaders) {
        [responseHeaders appendString:key];
        [responseHeaders appendString:@": "];
        [responseHeaders appendString:_responseHeaders[key]];
        [responseHeaders appendString:@"\r\n"];
    }
    return responseHeaders;
#pragma clang diagnostic pop
}

- (NSString *)getResponseHeader:(NSString *)name {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
    return _responseHeaders[name];
#pragma clang diagnostic pop
}

- (void)setAllResponseHeaders:(NSDictionary *)responseHeaders {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
    _responseHeaders = responseHeaders;
#pragma clang diagnostic pop
}

@end

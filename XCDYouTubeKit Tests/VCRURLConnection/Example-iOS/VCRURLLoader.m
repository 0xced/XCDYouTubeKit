//
//  VCRURLLoader.m
//  VCRURLConnection
//
//  Created by Dustin Barker on 1/3/14.
//
//

#define __VCR_USE_NSURLSESSION 0

#import "VCRURLLoader.h"

@interface VCRURLLoader ()
@property (nonatomic, weak) id<VCRURLLoaderDelegate> delegate;
@property (nonatomic, strong) NSData *data;
@end

@implementation VCRURLLoader

- (id)initWithDelegate:(id<VCRURLLoaderDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)loadURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
#if __VCR_USE_NSURLSESSION
    __block typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                  dataTaskWithRequest:request
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (response) {
                                          [weakSelf.delegate URLLoader:weakSelf didReceiveResponse:(NSHTTPURLResponse *)response];
                                      }
                                      
                                      if (data) {
                                          [weakSelf.delegate URLLoader:weakSelf didLoadData:data];
                                      }
                                      
                                      if (error) {
                                          [weakSelf.delegate URLLoader:weakSelf didFailWithError:error];
                                      } else {
                                          [weakSelf.delegate URLLoaderDidFinishLoading:weakSelf];
                                      }
                                  }];
    [task resume];
#else
    [NSURLConnection connectionWithRequest:request delegate:self];
#endif
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    [self.delegate URLLoader:self didReceiveResponse:response];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (self.data) {
        NSMutableData *currentData = [NSMutableData dataWithData:self.data];
        [currentData appendData:data];
        self.data = currentData;
    } else {
        self.data = data;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate URLLoader:self didLoadData:self.data];
    [self.delegate URLLoader:self didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.delegate URLLoader:self didLoadData:self.data];
    [self.delegate URLLoaderDidFinishLoading:self];
}

@end

//
//  VCRURLLoader.h
//  VCRURLConnection
//
//  Created by Dustin Barker on 1/3/14.
//
//

#import <Foundation/Foundation.h>

@class VCRURLLoader;

@protocol VCRURLLoaderDelegate <NSObject>
- (void)URLLoader:(VCRURLLoader *)loader didReceiveResponse:(NSHTTPURLResponse *)response;
- (void)URLLoader:(VCRURLLoader *)loader didLoadData:(NSData *)data;
- (void)URLLoader:(VCRURLLoader *)loader didFailWithError:(NSError *)error;
- (void)URLLoaderDidFinishLoading:(VCRURLLoader *)loader;
@end

@interface VCRURLLoader : NSObject

- (id)initWithDelegate:(id<VCRURLLoaderDelegate>)delegate;
- (void)loadURL:(NSURL *)url;

@end

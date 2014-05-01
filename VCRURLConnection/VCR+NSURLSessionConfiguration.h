//
//  VCR+NSURLSessionConfiguration.h
//  VCRURLConnection
//
//  Created by Dustin Barker on 1/3/14.
//
//

#import "VCR.h"

@interface VCR (NSURLSessionConfiguration)
void VCRAddProtocolsToNSURLSessionConfiguration();
void VCRRemoveProtocolsFromNSURLSessionConfiguration();
@end

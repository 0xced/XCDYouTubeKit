//
//  VCR+NSURLSessionConfiguration.m
//  VCRURLConnection
//
//  Created by Dustin Barker on 1/3/14.
//
//

#import "VCR+NSURLSessionConfiguration.h"

#import <Availability.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 || __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090

#import "VCRRecordingURLProtocol.h"
#import "VCRReplayingURLProtocol.h"
#import <objc/runtime.h>

typedef NSURLSessionConfiguration *(*VCR_NSURLSessionConfigurationConstructor)(id, SEL);

static VCR_NSURLSessionConfigurationConstructor VCR_original_defaultSessionConstructor;
static VCR_NSURLSessionConfigurationConstructor VCR_original_ephemeralSessionConstructor;

void VCR_addProtocolsToConfiguration(NSURLSessionConfiguration *configuration) {
    NSMutableArray *protocols = [NSMutableArray arrayWithArray:[configuration protocolClasses]];
    [protocols insertObject:[VCRRecordingURLProtocol class] atIndex:0];
    [protocols insertObject:[VCRReplayingURLProtocol class] atIndex:1];
    [configuration setProtocolClasses:protocols];
}

NSURLSessionConfiguration *VCR_defaultSessionConstructor(id self, SEL _cmd) {
    NSURLSessionConfiguration *configuration = VCR_original_defaultSessionConstructor(self, _cmd);
    VCR_addProtocolsToConfiguration(configuration);
    return configuration;
}

NSURLSessionConfiguration *VCR_ephemeralSessionConstructor(id self, SEL _cmd) {
    NSURLSessionConfiguration *configuration = VCR_original_ephemeralSessionConstructor(self, _cmd);
    VCR_addProtocolsToConfiguration(configuration);
    return configuration;
}

static VCR_NSURLSessionConfigurationConstructor VCRSwizzleNSURLSessionConfiguration(SEL selector, VCR_NSURLSessionConfigurationConstructor newImp) {
    Class clazz = object_getClass([NSURLSessionConfiguration class]);
    Method method = class_getClassMethod(clazz, selector);
    VCR_NSURLSessionConfigurationConstructor oldImp = (VCR_NSURLSessionConfigurationConstructor)method_getImplementation(method);
    method_setImplementation(method, (IMP)newImp);
    return oldImp;
}

void VCRAddProtocolsToNSURLSessionConfiguration() {
    VCR_NSURLSessionConfigurationConstructor newImp;
    VCR_NSURLSessionConfigurationConstructor oldImp;
    
    // override defaultSessionConfiguration constructor
    newImp = VCR_defaultSessionConstructor;
    oldImp = VCRSwizzleNSURLSessionConfiguration(@selector(defaultSessionConfiguration), newImp);
    if (oldImp != newImp) {
        VCR_original_defaultSessionConstructor = oldImp;
    }
    
    // override ephemeralSessionConfigurationConstructor
    newImp = VCR_ephemeralSessionConstructor;
    oldImp = VCRSwizzleNSURLSessionConfiguration(@selector(ephemeralSessionConfiguration), newImp);
    if (oldImp != newImp) {
        VCR_original_ephemeralSessionConstructor = oldImp;
    }
}

#else

// noop for compatibility
void VCRAddProtocolsToNSURLSessionConfiguration() {}

#endif

@implementation VCR (NSURLSessionConfiguration)
@end


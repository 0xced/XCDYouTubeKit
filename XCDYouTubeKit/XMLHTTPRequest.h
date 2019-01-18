#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


typedef NS_ENUM(NSUInteger , ReadyState) {
    XMLHttpRequestUNSENT =0,	// open()has not been called yet.
    XMLHttpRequestOPENED,	    // send()has not been called yet.
    XMLHttpRequestHEADERS,      // RECEIVED	send() has been called, and headers and status are available.
    XMLHttpRequestLOADING,      // Downloading; responseText holds partial data.
    XMLHttpRequestDONE          // The operation is complete.
};

@protocol XMLHttpRequest <JSExport>
@property (nonatomic) NSString *response;
@property (nonatomic) NSString *responseText;
@property (nonatomic) NSString *responseType;
@property (nonatomic) JSValue *onreadystatechange;
@property (nonatomic) NSNumber *readyState;
@property (nonatomic) JSValue *onload;
@property (nonatomic) JSValue *onerror;
@property (nonatomic) NSNumber *status;
@property (nonatomic) NSString *statusText;


-(void)open:(NSString *)httpMethod :(NSString *)url :(bool)async;
-(void)send:(id)data;
-(void)setRequestHeader: (NSString *)name :(NSString *)value;
-(NSString *)getAllResponseHeaders;
-(NSString *)getResponseHeader:(NSString *)name;

@end



@interface XMLHttpRequest : NSObject <XMLHttpRequest>

- (instancetype)initWithURLSession: (NSURLSession *)urlSession;

- (void)extend:(id)jsContext;
@end



//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface iService : NSObject

/**
 @param Success is the callback after having response.
 @param failure is the callback for fail
 */

+ (void)getJsonResponse : (NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success;

+ (void)postRequestWithURL : (NSString *)urlStr jsonDataConvertFrom:(NSDictionary *)postDictionary success : (void (^)(NSDictionary *responseDict))success;

+ (void)postRequestWithURL : (NSString *)urlStr urlDataConvertFrom:(NSDictionary *)postDictionary success : (void (^)(NSDictionary *responseDict))success;
@end

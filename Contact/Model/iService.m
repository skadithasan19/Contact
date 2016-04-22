

//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "iService.h"


@implementation iService


/**
 @param Success is the callback after having response.
 @param failure is the callback for fail
 */

 + (void)getJsonResponse : (NSString *)urlStr success : (void (^)(NSDictionary *responseDict))success
{
    

    NSURL * url = [NSURL URLWithString: urlStr];
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
   __block NSError *jsonError = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(data) {
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            success(jsonObject);
        }
            else {
                NSLog(@"Couldn't reach to the Server. Please Try again Later.");
            }
        });
    }];
    
    [dataTask resume] ;
    
}


@end

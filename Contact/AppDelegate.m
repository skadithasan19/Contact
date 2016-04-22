//
//  AppDelegate.m
//  Contact
//
//  Created by Md Adit Hasan on 4/21/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    // Accessing the end point
    [[ContactManager shareInstance] loadDataFromAPI];
}



@end

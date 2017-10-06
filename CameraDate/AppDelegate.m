//
//  AppDelegate.m
//  CameraDate
//
//  Created by KaeJer Cho on 2015/11/6.
//  Copyright © 2015年 KaeJer Cho. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <ObjectiveDropboxOfficial/ObjectiveDropboxOfficial.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [DBClientsManager setupWithAppKey:@"p6pmqjt05kqa7s1"];
    

    [Fabric with:@[[Crashlytics class]]];

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
//  sourceApplication:(NSString *)source annotation:(id)annotation {
//    ViewController* mainController = self.window.rootViewController;
//    if ([[DBSession sharedSession] handleOpenURL:url]) {
//        if ([[DBSession sharedSession] isLinked]) {
//            NSLog(@"App linked successfully!");
//            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//            [userDefault setBool:YES forKey:@"dblink"];
//            [userDefault synchronize];
//            [mainController.btn removeFromSuperview];
//            // At this point you can start making API calls
//        }
//        return YES;
//    }
//    // Add whatever other url handling code your app requires here
//    return NO;
//}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    DBOAuthResult *authResult = [DBClientsManager handleRedirectURL:url];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (authResult != nil) {
        if ([authResult isSuccess]) {
            NSLog(@"Success! User is logged into Dropbox.");
            [userDefault setBool:YES forKey:@"dblink"];
            ViewController *topController = (ViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
            [topController Camerainit];
        } else if ([authResult isCancel]) {
            NSLog(@"Authorization flow was manually canceled by user!");
            [userDefault setBool:NO forKey:@"dblink"];
        } else if ([authResult isError]) {
            NSLog(@"Error: %@", authResult);
            [userDefault setBool:NO forKey:@"dblink"];
        }
        [userDefault synchronize];
        
    }
    return NO;
}

@end

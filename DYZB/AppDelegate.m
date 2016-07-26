//
//  AppDelegate.m
//  DYZB
//
//  Created by guibinfeng on 16/7/20.
//  Copyright © 2016年 guibinfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingAdViewController.h"
#import "BGVideoPalyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self downloadFile];
    [NSThread sleepForTimeInterval:1.0f];
    self.window = [[UIWindow alloc] initWithFrame:SCREEN_RECT];
    self.window.rootViewController = [[LoadingAdViewController alloc] init];
    //    self.window.rootViewController = [[BGVideoPalyViewController alloc] init];
    [self.window makeKeyAndVisible];
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
//    [self downloadFile];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)downloadFile
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img1.126.net/channel6/2015/020002/2.jpg?dpi=6401136"] cachePolicy:1 timeoutInterval:6];
    [[manger downloadTaskWithRequest:request progress:NULL destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        [self saveADFilePath:filePath];
        return url;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
    }] resume];
}

- (void)saveADFilePath:(NSString *)filePath {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:filePath forKey:@"filePath"];
    [user setObject:@"https://www.google.com.hk" forKey:@"url"];
    [user synchronize];
}

@end

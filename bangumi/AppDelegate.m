//
//  AppDelegate.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/17.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Init...");
    NSLog(@"Powered by");
    NSLog(@"██████╗  █████╗ ███╗   ██╗ ██████╗ ██╗   ██╗███╗   ███╗██╗");
    NSLog(@"██╔══██╗██╔══██╗████╗  ██║██╔════╝ ██║   ██║████╗ ████║██║");
    NSLog(@"██████╔╝███████║██╔██╗ ██║██║  ███╗██║   ██║██╔████╔██║██║");
    NSLog(@"██╔══██╗██╔══██║██║╚██╗██║██║   ██║██║   ██║██║╚██╔╝██║██║");
    NSLog(@"██████╔╝██║  ██║██║ ╚████║╚██████╔╝╚██████╔╝██║ ╚═╝ ██║██║");
    NSLog(@"╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝");
    NSLog(@"Product by ©bi119aTe5hXk 2015-2019.");
    NSLog(@"なにこれ(°Д°)？！");
    application.statusBarHidden = NO;
    // Override point for customization after application launch.
    
    if (debugmode == YES) {
        NSLog(@"Your system version is:%@",[[UIDevice currentDevice] systemVersion]);
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"欢迎使用番组计划+测试版" message:@"这是测试版app，如果有任何问题请找@bi119aTe5hXk。谢谢。" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alert animated:YES completion:nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"欢迎使用番组计划+测试版"
                                                            message:@"这是测试版app，如果有任何问题请找@bi119aTe5hXk。谢谢。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好的"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    NSUserDefaults *userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"auth",nil]];
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"auth_urlencoded",nil]];
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"", @"userid",nil]];
    [userdefaults synchronize];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
    if(debugmode == YES){
        NSLog(@"%@",shortcutItem);
        NSLog(@"userinfo:%@", [shortcutItem.userInfo valueForKey:@"key1"]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shortCutNotification"
                                                        object:nil
                                                      userInfo:shortcutItem.userInfo];
    
}
@end

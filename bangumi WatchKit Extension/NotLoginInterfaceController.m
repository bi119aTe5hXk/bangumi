//
//  NotLoginInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 bi119aTe5hXk. All rights reserved.
//

#import "NotLoginInterfaceController.h"

@interface NotLoginInterfaceController ()

@end

@implementation NotLoginInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self setTitle:@" "];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
   
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSLog(@"New Session Context: %@", applicationContext);
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    
    for (NSString *key in applicationContext.allKeys) {
        [defaults setObject:[applicationContext objectForKey:key] forKey:key];
    }
    
    [defaults synchronize];
    
    [self dismissController];
}
-(void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error{
    NSLog(@"activationDidCompleteWithState: %ld", (long)activationState);
    
    
    [self dismissController];
}
- (IBAction)retrybtn {
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    [userdefaults synchronize];
    [self checkauth];
    
}
- (IBAction)retrybtn2{
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    [userdefaults synchronize];
    [self checkauth];
}
-(void)checkauth{
    NSString *auth = [userdefaults stringForKey:@"auth"];
    if (debugmode == YES) {
        NSLog(@"watchauth2:%@",auth);
    }
    if ([auth length] <= 0) {
    }else{
        [self dismissController];
    }
}
@end




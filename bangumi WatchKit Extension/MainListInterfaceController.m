//
//  MainListInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import "MainListInterfaceController.h"

@interface MainListInterfaceController ()

@end

@implementation MainListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    userdefaults = [NSUserDefaults standardUserDefaults];
    
    auth = [userdefaults stringForKey:@"auth"];
    if ([auth length] == 0) {
        [self pushControllerWithName:@"NotLoginInterfaceController" context:NULL];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end




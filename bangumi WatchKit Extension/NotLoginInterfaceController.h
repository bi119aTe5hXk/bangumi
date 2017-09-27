//
//  NotLoginInterfaceController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 bi119aTe5hXk. All rights reserved.
//
#import "API.h"
#import "MainListInterfaceController.h"
#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <WatchConnectivity/WatchConnectivity.h>
@interface NotLoginInterfaceController : WKInterfaceController<WCSessionDelegate>{
    NSUserDefaults *userdefaults;
}
- (IBAction)retrybtn;

@end

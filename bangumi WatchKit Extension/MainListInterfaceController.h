//
//  MainListInterfaceController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "BGMWKCell.h"
#import "BGMAPI.h"
#import "NotificationController.h"
#import "HTMLEntityDecode.h"
#import "DetailWKInterfaceController.h"
@interface MainListInterfaceController : WKInterfaceController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSArray *bgmlist;
    NSUserDefaults *userdefaults;
    NSString *auth;
}
@property (nonatomic, strong) IBOutlet WKInterfaceTable *tableview;
@end

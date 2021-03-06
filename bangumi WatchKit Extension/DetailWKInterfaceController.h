//
//  DetailWKInterfaceController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/17.
//  Copyright (c) 2015年 bi119aTe5hXk. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "BGMAPI.h"
#import "HTMLEntityDecode.h"

@interface DetailWKInterfaceController : WKInterfaceController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSArray *detailarr;
    NSString *request_type;
    NSInteger ep_count;
    NSString *bgmid;
}

@property (nonatomic, strong) IBOutlet WKInterfaceImage *imageview;
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *title_org;
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *title_cn;
@property (nonatomic, strong) IBOutlet WKInterfaceLabel *progresslabel;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *watchedbtn;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *statusbtn;
-(IBAction)backbtn:(id)sender;
-(IBAction)watchedbtn:(id)sender;
-(IBAction)setBGMStatus:(id)sender;
@end

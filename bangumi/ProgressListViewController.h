//
//  ProgressListViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressCell.h"
#import "WebViewController.h"
@interface ProgressListViewController : UITableViewController<BGMAPIDelegate,UIAlertViewDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSArray *statuslist;
    NSString *request_type;
    
    NSInteger selectrow;
}
@property (nonatomic) NSString *subid;
@property (nonatomic) NSArray *progresslist;


@end

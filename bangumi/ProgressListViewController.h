//
//  ProgressListViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SafariServices;
#import "ProgressCell.h"
//#import "WebViewController.h"
@interface ProgressListViewController : UITableViewController<BGMAPIDelegate,UIAlertViewDelegate,SFSafariViewControllerDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSMutableArray *statuslist;
    
    NSString *request_type;
    
    NSInteger selectrow;
}
@property (nonatomic) NSString *subid;
@property (nonatomic) NSArray *progresslist;


@end

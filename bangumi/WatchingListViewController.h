//
//  WatchingListViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SafariServices;
#import "BGMCell.h"
#import "BGMDetailViewController.h"
//#import "WebViewController.h"
#import "LoginViewController.h"
@interface WatchingListViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,BGMAPIDelegate,UIAlertViewDelegate,SFSafariViewControllerDelegate>{
    NSUserDefaults *userdefault;
    BGMAPI *bgmapi;
    NSString *request_type;
    NSArray *bgmlist;
    NSInteger ep_count;
    NSString *epid;
    NSString *auth;
    NSString *disscussurl;
    
    
}
@property (strong, nonatomic) BGMDetailViewController *detailviewcontroller;
@property (strong, nonatomic) LoginViewController *loginviewcontroller;

@end

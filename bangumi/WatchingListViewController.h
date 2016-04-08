//
//  WatchingListViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGMCell.h"
#import "BGMDetailViewController.h"
#import "WebViewController.h"
@interface WatchingListViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,BGMAPIDelegate,UIAlertViewDelegate>{
    NSUserDefaults *userdefault;
    BGMAPI *bgmapi;
    NSString *request_type;
    NSArray *bgmlist;
    NSInteger ep_count;
    NSString *epid;
    
    NSString *disscussurl;
}
@property (strong, nonatomic) BGMDetailViewController *detailviewcontroller;

@end

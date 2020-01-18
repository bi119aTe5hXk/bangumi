//
//  DaliyListViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/30.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGMDetailViewController.h"
//#import "NormalCell.h"
#import "DailyCell.h"
@interface DaliyListViewController : UITableViewController<BGMAPIDelegate,SFSafariViewControllerDelegate>{
    BGMAPI *bgmapi;
    NSArray *daylist;
}
-(void)getUserActivityState:(NSNotification *)notification;

@end

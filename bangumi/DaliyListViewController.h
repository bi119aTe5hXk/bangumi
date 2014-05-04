//
//  DaliyListViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/30.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGMDetailViewController.h"
#import "NormalCell.h"
@interface DaliyListViewController : UITableViewController<BGMAPIDelegate>{
    NSUserDefaults *userdefaults;
    BGMAPI *bgmapi;
    NSArray *daylist;
}


@end

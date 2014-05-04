//
//  SearchViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/04.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalCell.h"
#import "BGMDetailViewController.h"
@interface SearchViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,BGMAPIDelegate,UISearchBarDelegate>{
    NSUserDefaults *userdefaults;
    BGMAPI *bgmapi;
    NSArray *resultlist;
}
@property (nonatomic, retain) IBOutlet UISearchBar *seachbar;
@end

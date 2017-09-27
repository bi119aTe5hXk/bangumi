//
//  SearchViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/04.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalCell.h"
#import "BGMDetailViewController.h"
@interface SearchViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,BGMAPIDelegate,UISearchBarDelegate>{
    BGMAPI *bgmapi;
    NSArray *resultlist;
    
}
@property (nonatomic, retain) IBOutlet UISearchBar *seachbar;

-(IBAction)searchinfo:(id)sender;
@end

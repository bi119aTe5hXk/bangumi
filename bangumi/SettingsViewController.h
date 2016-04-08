//
//  SettingsViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
@interface SettingsViewController : UITableViewController<BGMAPIDelegate>{
    NSUserDefaults *userdefault;
    BGMAPI *bgmapi;
}

@property (nonatomic, strong) IBOutlet UIButton *rakuenbtn;
@property (nonatomic ,strong)  WebViewController *webview;
//@property (nonatomic, strong) IBOutlet UILabel *creditText;
-(IBAction)openRakuen:(id)sender;
-(IBAction)logout:(id)sender;
@end

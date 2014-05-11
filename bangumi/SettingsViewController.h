//
//  SettingsViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController{
    NSUserDefaults *userdefault;
}

-(IBAction)logout:(id)sender;
@end

//
//  LoginViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarViewController.h"
@interface LoginViewController : UIViewController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSArray *resultarr;
    NSUserDefaults *userdefaults;
    NSString *auth;
    NSString *userid;
    
}
@property (nonatomic, strong) IBOutlet UITextField *usernamefield;
@property (nonatomic, strong) IBOutlet UITextField *passwordfield;

@property (nonatomic, strong) IBOutlet TabbarViewController *tabbarview;

-(IBAction)loginbtnpressd:(id)sender;


@end

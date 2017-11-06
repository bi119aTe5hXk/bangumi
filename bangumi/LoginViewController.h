//
//  LoginViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>
//#import "WebViewController.h"
@import SafariServices;
@interface LoginViewController : UIViewController<BGMAPIDelegate,UITextFieldDelegate,WCSessionDelegate,SFSafariViewControllerDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSString *auth;
    NSString *auth_urlencoded;
    NSString *userid;
    NSString *request_type;
    
    
    
}
@property (nonatomic, strong) IBOutlet UITextField *usernamefield;
@property (nonatomic, strong) IBOutlet UITextField *passwordfield;

@property (nonatomic, strong) IBOutlet SplitViewController *splitview;



-(IBAction)loginbtnpressd:(id)sender;
-(IBAction)registerbtnpressed:(id)sender;
@end

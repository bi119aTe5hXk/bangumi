//
//  BGMDetailViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/19.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SafariServices;
#import "ProgressListViewController.h"
//#import "WebViewController.h"
#import "LoginViewController.h"
@interface BGMDetailViewController : UIViewController<BGMAPIDelegate,SFSafariViewControllerDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSString *request_type;
    NSString *bgmid1;
    NSArray *progresslist;
    NSString *auth;
}
@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) NSString *bgmidstr;

//@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) IBOutlet UIButton *statusmanabtn;
@property (nonatomic, strong) IBOutlet UIButton *progressmanabtn;
@property (nonatomic, strong) IBOutlet UIImageView *cover;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel_cn;
@property (nonatomic, strong) IBOutlet UILabel *ratscoretitle;
@property (nonatomic, strong) IBOutlet UILabel *ratscore;
@property (nonatomic, strong) IBOutlet UITextView *bgmsummary;
@property (nonatomic, strong) IBOutlet UILabel *ranktitle;
@property (nonatomic, strong) IBOutlet UILabel *rankscore;
@property (nonatomic, strong) IBOutlet UIButton *bgmdetailbtn;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *actionbtn;

@property (nonatomic, strong) LoginViewController *loginviewcontroller;

-(void)startGetSubjectInfoWithID:(NSString *)bgmid;
-(IBAction)PorgressViewBTN:(id)sender;
-(IBAction)BGMStatuesBTN:(id)sender;
-(IBAction)showDetailWebBTN:(id)sender;
-(IBAction)shareBTN:(id)sender;
@end

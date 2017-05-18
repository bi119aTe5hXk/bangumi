//
//  BGMDetailViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/19.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressListViewController.h"
#import "WebViewController.h"
@interface BGMDetailViewController : UIViewController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSString *request_type;
    NSString *bgmid1;
    NSArray *progresslist;
}
@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) NSString *bgmidstr;

//@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) IBOutlet UIButton *statusmanabtn;
@property (nonatomic, strong) IBOutlet UIButton *progressmanabtn;
@property (nonatomic, strong) IBOutlet UIImageView *cover;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel_cn;

@property (nonatomic, strong) IBOutlet UITextView *bgmsummary;

-(void)startGetSubjectInfoWithID:(NSString *)bgmid;
-(IBAction)PorgressViewBTN:(id)sender;
-(IBAction)BGMStatuesBTN:(id)sender;
-(IBAction)showDetailWebBTN:(id)sender;
@end

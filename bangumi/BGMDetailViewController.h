//
//  BGMDetailViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/19.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressListViewController.h"
@interface BGMDetailViewController : UIViewController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSString *request_type;
    
    NSArray *progresslist;
}

@property (nonatomic, strong) NSString *bgmid;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) IBOutlet UIButton *statusmanabtn;
@property (nonatomic, strong) IBOutlet UIButton *progressmanabtn;
@property (nonatomic, strong) IBOutlet UIImageView *cover;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel_cn;

@property (nonatomic, strong) IBOutlet UITextView *bgmsummary;


-(IBAction)PorgressViewBTN:(id)sender;
-(IBAction)BGMStatuesBTN:(id)sender;

@end

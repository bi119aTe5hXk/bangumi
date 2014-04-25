//
//  BGMDetailViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/19.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGMDetailViewController : UIViewController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSUserDefaults *userdefaults;
    NSString *request_type;
}

@property (nonatomic, strong) NSString *bgmid;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) IBOutlet UIButton *progressmanabtn;
@property (nonatomic, strong) IBOutlet UIImageView *cover;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel_cn;

@property (nonatomic, strong) IBOutlet UITextView *bgmsummary;


@end

//
//  BGMDetailViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/19.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "BGMDetailViewController.h"

@interface BGMDetailViewController ()

@end

@implementation BGMDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self WithAuthString:[userdefaults stringForKey:@"auth"]];
    [bgmapi getSubjectInfoWithSubID:self.bgmid];
    request_type = @"BGMDetail";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.progressmanabtn setHidden:YES];
    [self.statusmanabtn setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}
-(void)viewWillAppear:(BOOL)animated{
    
//    self.titlelabel.text = @"";
//    self.titlelabel_cn.text = @"";
//    self.bgmsummary.text = @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.progressmanabtn setHidden:NO];
    [self.statusmanabtn setHidden:NO];
    if ([request_type isEqualToString:@"BGMDetail"]) {
        self.titlelabel.text = [list valueForKey:@"name"];
        self.titlelabel_cn.text = [list valueForKey:@"name_cn"];
        [self.cover setImageWithURL:[NSURL URLWithString:[[list valueForKey:@"images"] valueForKey:@"common"]]];
        
        self.bgmsummary.text = [list valueForKey:@"summary"];
        
        [self.bgmsummary setFont:[UIFont systemFontOfSize:12]];
        CGSize stringSize = [self.bgmsummary.text sizeWithFont:[UIFont systemFontOfSize:12]
                             constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)
                                 lineBreakMode:NSLineBreakByWordWrapping];
        
        
        [self.bgmsummary setFrame:CGRectMake(20, 212, 280, stringSize.height+200)];
        [self.scrollview setContentSize:CGSizeMake(320, stringSize.height + 300)];
        [self.scrollview setScrollEnabled:YES];
        
        
    }
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  LoginViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    bgmapi = [[BGMAPI alloc] initWithdelegate:self WithAuthString:nil];
    userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:nil, @"auth",nil]];
    [userdefaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:nil, @"userid",nil]];
    auth = [userdefaults stringForKey:@"auth"];
    userid = [userdefaults stringForKey:@"userid"];
    NSLog(@"auth:%@",auth);
    
    if ([auth length] > 0) {
        self.tabbarview = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
        [self.navigationController presentViewController:self.tabbarview animated:NO completion:nil];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginbtnpressd:(id)sender{
    if ([self.usernamefield.text length] > 0 && [self.passwordfield.text length] > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [bgmapi userLoginWithUserName:self.usernamefield.text WithPassword:self.passwordfield.text];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入用户名密码！"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    resultarr = list;
    auth = [list valueForKey:@"auth_encode"];
    userid = [list valueForKey:@"id"];
    if ([auth length] > 0) {
        [userdefaults setObject:auth forKey:@"auth"];
        [userdefaults setObject:userid forKey:@"userid"];
        [userdefaults synchronize];
        self.tabbarview = [self.storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
        [self.navigationController presentViewController:self.tabbarview animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名密码错误！"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    
//    
//}


@end

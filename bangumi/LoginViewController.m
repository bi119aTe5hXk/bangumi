//
//  LoginViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
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
    
    
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    
    
    auth_urlencoded = [userdefaults stringForKey:@"auth_urlencoded"];
    auth = [userdefaults stringForKey:@"auth"];
    userid = [userdefaults stringForKey:@"userid"];
    [userdefaults synchronize];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    if (debugmode == YES) {
        NSLog(@"auth:%@,auth_URLencoded:%@",auth,auth_urlencoded);
    }
    
    if ([auth length] > 0) {
        [self pushSettingsToWatchApp];
        
//        self.splitview = [self.storyboard instantiateViewControllerWithIdentifier:@"SplitViewController"];
//        [self.navigationController presentViewController:self.splitview animated:NO completion:nil];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    
    
    
}


- (void)pushSettingsToWatchApp
{
    if ([WCSession isSupported]) {
        NSLog(@"START PUSH SETTINGS TO WATCH");
        WCSession* session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
        
        
        [[WCSession defaultSession] updateApplicationContext:[[[NSUserDefaults alloc] initWithSuiteName:groupName] dictionaryRepresentation] error:nil];
    }
    

}




-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}
-(void)viewWillAppear:(BOOL)animated{
    self.usernamefield.text = @"";
    self.passwordfield.text = @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)registerbtnpressed:(id)sender{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://bgm.tv/signup"]];
//    WebViewController *webview  = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
//    webview.urlstr = @"https://bgm.tv/signup";
//    webview.titlestr = @"注册 bangumi";
//    [self.navigationController presentViewController:webview animated:YES completion:nil];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://bgm.tv/signup"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:YES completion:nil];
}
-(IBAction)loginbtnpressd:(id)sender{
    if ([self.usernamefield.text length] > 0 && [self.passwordfield.text length] > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [bgmapi userLoginWithUserName:self.usernamefield.text WithPassword:self.passwordfield.text];
        request_type = @"login";
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入用户名和密码！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入用户名和密码！"
//                                                        message:nil
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
    }
    
}

-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([request_type isEqualToString:@"login"]) {
        auth_urlencoded = [list valueForKey:@"auth_encode"];
        auth = [list valueForKey:@"auth"];
        userid = [list valueForKey:@"id"];
        if ([auth length] > 0) {
            [userdefaults setObject:auth forKey:@"auth"];
            [userdefaults setObject:userid forKey:@"userid"];
            [userdefaults setObject:auth_urlencoded forKey:@"auth_urlencoded"];
            [userdefaults synchronize];
            [self pushSettingsToWatchApp];
//            dispatch_async(dispatch_get_main_queue(),^{
////                self.splitview = [self.storyboard instantiateViewControllerWithIdentifier:@"SplitViewController"];
////                [self.navigationController presentViewController:self.splitview animated:YES completion:nil];
//
//            });
            dispatch_async(dispatch_get_main_queue(),^{
                [self dismissViewControllerAnimated:YES completion:NULL];
            });
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户名密码错误！" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
//            dispatch_async(dispatch_get_main_queue(),^{
//
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名密码错误！"
////                                                                message:nil
////                                                               delegate:nil
////                                                      cancelButtonTitle:@"OK"
////                                                      otherButtonTitles:nil, nil];
////                [alert show];
//            });
            
        }
    }
    
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	switch (textField.returnKeyType) {
		case UIReturnKeyNext:
			[self.passwordfield becomeFirstResponder];
			break;
		case UIReturnKeyDone:
			[textField resignFirstResponder];
			[self loginbtnpressd:nil];
			break;
		default:
			break;
	}
	return YES;
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
-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

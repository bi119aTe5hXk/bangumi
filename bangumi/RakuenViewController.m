//
//  RakuenViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "RakuenViewController.h"

@interface RakuenViewController ()

@end

@implementation RakuenViewController

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
    self.title = @"超展开 Mobile";
    userdefault = [NSUserDefaults standardUserDefaults];
    
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rakuenURL]];
    
    //[request setValue:[userdefault stringForKey:@"auth"] forHTTPHeaderField:@"chii_auth"];
    
//    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
//    [cookiePropertiesUser setObject:@".bgm.tv" forKey:NSHTTPCookieDomain];
//    [cookiePropertiesUser setObject:@"chii_auth" forKey:NSHTTPCookieName];
//    [cookiePropertiesUser setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookiePropertiesUser setObject:[userdefault stringForKey:@"auth_urlencoded"] forKey:NSHTTPCookieValue];
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    
    NSURL *url = [NSURL URLWithString:rakuenURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url ]; // cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [self.webview loadRequest:request];
    [self.webview setDelegate:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [cookieJar cookies]) {
        //[self.cookies addObject:cookie];
        if (debugmode == YES) {
            NSLog(@"cookie:%@",cookie);
        }
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
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

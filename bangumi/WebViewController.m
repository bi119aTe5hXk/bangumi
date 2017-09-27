//
//  RakuenViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self saveCookie];
}
-(IBAction)closeWebView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        NULL;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"超展开 Mobile";
    self.title = self.titlestr;
    self.navitem.title = self.titlestr;
    //UINavigationItem *items = [[UINavigationItem alloc] initWithTitle:@""];
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                      target:self
                                      action:@selector(backbtn:)];
    UIBarButtonItem *refreshbutton = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(reloadpage:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:refreshbutton,backbutton,nil];
    
    userdefault = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    [self loadCookie];
    
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                               @"chii_auth", NSHTTPCookieName,
//                                                               [userdefault stringForKey:@"auth"], NSHTTPCookieValue,
//                                                               @".bgm.tv", NSHTTPCookieDomain,
//                                                               @"/", NSHTTPCookiePath,
//                                                               [NSDate distantFuture], NSHTTPCookieExpires,
//                                                               nil]];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSURL *url = [NSURL URLWithString:self.urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];

    //[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webview loadRequest:request];
        [self.webview setDelegate:self];
    });
    
}
- (void)loadCookie{
    NSData *cookiesData = [userdefault objectForKey:@"SavedHTTPCookiesKey"];
    if (cookiesData) {
        NSLog(@"load cookies");
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        for (NSHTTPCookie *cookie in cookies)
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
}
- (void)saveCookie{
    // Save the cookies to the user defaults
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    [userdefault setObject:cookiesData forKey:@"SavedHTTPCookiesKey"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)reloadpage:(id)sender{
    [self.webview reload];
}
-(IBAction)backbtn:(id)sender{
    [self.webview goBack];
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
    [self saveCookie];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    [self saveCookie];
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

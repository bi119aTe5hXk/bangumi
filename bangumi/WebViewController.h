//
//  RakuenViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>{
    NSUserDefaults *userdefault;
    
}
@property (strong, nonatomic) NSString *titlestr;
@property (strong, nonatomic) NSString *urlstr;
@property (nonatomic, strong) IBOutlet UIWebView *webview;
@property (nonatomic, strong) IBOutlet UINavigationItem *navitem;
@property (strong, nonatomic) NSURLConnection *theConnection;
@property (strong, nonatomic) NSMutableData *receivedData;

-(IBAction)reloadpage:(id)sender;
-(IBAction)backbtn:(id)sender;
-(IBAction)closeWebView:(id)sender;
@end

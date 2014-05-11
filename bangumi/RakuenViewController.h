//
//  RakuenViewController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RakuenViewController : UIViewController<UIWebViewDelegate>{
    NSUserDefaults *userdefault;
}
@property (nonatomic, retain) IBOutlet UIWebView *webview;
@end

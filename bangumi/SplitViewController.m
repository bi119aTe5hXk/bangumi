//
//  SplitViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2016/04/08.
//  Copyright © 2016年 bi119aTe5hXk. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController ()

@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.splitViewController.delegate = self;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    [self.splitViewController setPreferredDisplayMode: UISplitViewControllerDisplayModeAllVisible];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    //[self.tabBar safeAreaInsets];
    //NSLog(@"intrinsicContentSize.height:%f",self.tabBar.safeAreaInsets.bottom);
    //[self.tabBar invalidateIntrinsicContentSize];
//    self.tabBar.heightAnchor
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] &&
        [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[BGMDetailViewController class]] &&
        ([(BGMDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        NSLog(@"handled the collapse by doing nothing; the secondary controller will be discarded.");
        return YES;
    } else {
        NSLog(@"handled the collapse in splitVC");
        return NO;
    }
}

#pragma mark - User Activity methods
-(void)restoreUserActivityState:(NSUserActivity *)activity {
    NSString *bgmid = activity.userInfo[@"bgmid"];
    if (debugmode) {
        NSLog(@"restoreUserActivityState:%@ in SplitView",bgmid);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kRestoreNoficationName object:nil userInfo:@{@"bgmid":bgmid}];
}
@end

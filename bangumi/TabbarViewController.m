//
//  TabbarViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import "TabbarViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

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
//    UINavigationController *navigationController = [self.splitViewController.viewControllers lastObject];
//    navigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    //self.navigationController.navigationBar.hidden = YES;
    self.delegate = self;
    self.splitViewController.delegate = self;
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    [self.splitViewController setPreferredDisplayMode: UISplitViewControllerDisplayModeAllVisible];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
//    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tabBar invalidateIntrinsicContentSize];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    //[self.tabBar safeAreaInsets];
    //NSLog(@"intrinsicContentSize.height:%f",self.tabBar.safeAreaInsets.bottom);
    [self.tabBar invalidateIntrinsicContentSize];
//    self.tabBar.heightAnchor
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] &&
        [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[BGMDetailViewController class]] &&
        ([(BGMDetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        NSLog(@"handled the collapse by doing nothing; the secondary controller will be discarded.");
        return YES;
    } else {
        NSLog(@"handled the collapse in tabBarVC");
        return NO;
    }
}

@end

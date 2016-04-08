//
//  WatchingListViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "WatchingListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface WatchingListViewController ()

@end

@implementation WatchingListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    bgmlist = [[NSArray alloc] init];
    userdefault = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    //[self loadList];
}
- (void)onRefresh:(id)sender{
    [self loadList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}
-(void)viewDidAppear:(BOOL)animated{
    if (bgmlist.count <= 0) {
        [self loadList];
    }
}
-(void)loadList{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *userid = [userdefault stringForKey:@"userid"];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    [bgmapi cancelConnection];
    [bgmapi getWatchingListWithUID:userid];
    request_type = @"WatchingList";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.refreshControl endRefreshing];
    if ([request_type isEqualToString:@"WatchingList"]) {
        if ([list count] == 0) {
            
            UIAlertView *emptyalert = [[UIAlertView alloc] initWithTitle:@"列表是空的！"
                                                                 message:@"好像您没有订阅到任何番组，到每日放送里订阅一个吧～"
                                                                delegate:nil
                                                       cancelButtonTitle:@"知道了"
                                                       otherButtonTitles:nil, nil];
            [emptyalert show];
        }
        
        bgmlist = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [bgmapi getNotifyCount];
            request_type = @"notifycount";
        });
        
        
        
        
    }
    if ([request_type isEqualToString:@"updateProgress"]) {
        dispatch_async(dispatch_get_main_queue(),^{
            if ([[list valueForKey:@"error"] isEqualToString:@"OK"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已成功记录，要去看看讨论串吗？"
                                                                message:[list valueForKey:@"error"]
                                                               delegate:self
                                                      cancelButtonTitle:@"了解"
                                                      otherButtonTitles:@"去看看", nil];
                alert.tag = 3;
                [alert show];
                [self loadList];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"记录失败"
                                                                message:[list valueForKey:@"error"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"了解"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
        });
        
        
    }
    if ([request_type isEqualToString:@"EPList"]) {
        NSInteger ep_countindex = ep_count -1;
        if ([[list valueForKey:@"eps"] count] > 0 && ep_countindex <= [[list valueForKey:@"eps"] count]) {
            
            //remove sp
            NSArray *arr = [list valueForKey:@"eps"];
            NSArray *newlist = [NSArray array];
            for (int i=0; i<[arr count]; i++) {
                
                if ([[[arr objectAtIndex:i] valueForKey:@"type"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    newlist = [newlist arrayByAddingObject:[arr objectAtIndex:i]];
                }else{
                    
                }
            }
            
            NSString *epid1 = [[[newlist objectAtIndex:ep_countindex] valueForKey:@"id"] stringValue];
            disscussurl = [NSString stringWithFormat:@"http://bgm.tv/m/topic/ep/%@",epid1];
            //NSLog(@"epidd:%@",epid1);
            [bgmapi setProgressWithEPID:epid1 WithStatus:@"watched"];
            
            request_type = @"updateProgress";
            dispatch_async(dispatch_get_main_queue(),^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            });
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未知错误！"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"了解"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
    if ([request_type isEqualToString:@"notifycount"]) {
        NSString *count = [NSString stringWithFormat:@"%@",[list valueForKey:@"count"]];
        if ([count integerValue] >= 1) {
            [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%@",[list valueForKey:@"count"]]];
        }else{
            [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
        }
    }
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.refreshControl endRefreshing];
    if ([request_type isEqualToString:@"WatchingList"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [bgmapi getNotifyCount];
            request_type = @"notifycount";
        });
        
    }
}
#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return bgmlist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BGMCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    [cell.prgoressbar setProgress:0 animated:YES];
    NSArray *arr = [bgmlist objectAtIndex:row];
    cell.titlelabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name"]];
    
    
    NSInteger ep_status = [[arr valueForKey:@"ep_status"] integerValue];//已看
    NSInteger eps = [[[arr valueForKey:@"subject"] valueForKey:@"eps"] integerValue];//总共
    
    [cell.updatebtn setTitle:[NSString stringWithFormat:@"标记 ep.%ld 看过",(long)ep_status+1] forState:UIControlStateNormal];
    [cell.updatebtn addTarget:self action:@selector(updatebtnpressd:) forControlEvents:UIControlEventTouchUpInside];
    
    if (eps <= 0) {
        cell.progresslabel.text = [NSString stringWithFormat:@"%ld/??",(long)ep_status];
        //[cell.updatebtn setHidden:YES];
        if (ep_status <= 12) {
            eps = 12;
        }else{
            eps = 100;
        }
    }else if (eps == ep_status){
        cell.progresslabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)ep_status,(long)eps];
        //[cell.updatebtn setHidden:YES];
    }else{
        cell.progresslabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)ep_status,(long)eps];
        [cell.updatebtn setHidden:NO];
        
    }
    float i = ep_status;
    float f = eps;
    float percent = i/f;
    [cell.prgoressbar setProgress:percent animated:YES];
    
    
    NSString *iconurl = [[[arr valueForKey:@"subject"] valueForKey:@"images"] valueForKey:@"common"];
    //cell.icon setImageWithURL:[NSURL URLWithString:iconurl] placeholderImage:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl]];
        if (imgData) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.icon setImage:image];
                });
            }
        }
    });
    
    ep_status=0;
    eps=0;
    i=0;
    f=0;
    percent=0;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSArray *arr = [bgmlist objectAtIndex:row];
    NSInteger ep_status = [[arr valueForKey:@"ep_status"] integerValue];//已看
    return @[
             
             [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                title:[NSString stringWithFormat:@"标记 ep.%ld 看过",(long)ep_status+1]
                                              handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                  // own action
                                                  //[tableView setEditing:NO animated:YES];
                                                  [self updateStateWithIndex:indexPath];
                                                  
                                              }],
             ];
}
-(void)updatebtnpressd:(id)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    
    [self updateStateWithIndex:indexPath];
}
-(void)updateStateWithIndex:(NSIndexPath *)indexPath{
    
    if (indexPath != nil)
    {
        //NSLog(@"indexpath?:%ld",indexPath.row);
        NSUInteger row = [indexPath row];
        NSArray *arr = [bgmlist objectAtIndex:row];
        NSInteger ep_status = [[arr valueForKey:@"ep_status"] integerValue];//已看
        epid = [[arr valueForKey:@"subject"] valueForKey:@"id"];
        ep_count = ep_status+1;
        UIAlertView *updatealert = [[UIAlertView alloc] initWithTitle:@"确定将以下章节标为看过？"
                                                              message:[NSString stringWithFormat:@"%@ ep.%ld",[arr valueForKey:@"name"],(long)ep_count]
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"是的", nil];
        [updatealert setTag:2];
        [updatealert show];
        
    }

}

-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 2) {
        if (buttonIndex > 0) {
            if (buttonIndex == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [bgmapi getEPListWithSubID:epid];
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    request_type = @"EPList";
                });
                
            }
        }
    }else if (actionSheet.tag == 3){
        if (buttonIndex >0) {
            if (buttonIndex == 1) {
                //webview
                
                WebViewController *webview  = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
                webview.urlstr = disscussurl;
                webview.titlestr = @"条目讨论版";
                [self.navigationController presentViewController:webview animated:YES completion:nil];
            }
        }
    }
    
    
    
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    BGMDetailViewController *detailview = (BGMDetailViewController *)[[segue destinationViewController] topViewController] ;
    NSString *bgmid = [[[[bgmlist objectAtIndex:indexPath.row] valueForKey:@"subject"] valueForKey:@"id"] stringValue];
    [detailview startGetSubjectInfoWithID:bgmid];
    detailview.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    detailview.navigationItem.leftItemsSupplementBackButton = YES;
    
}




@end

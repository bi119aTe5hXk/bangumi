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
    userdefault = [NSUserDefaults standardUserDefaults];
    [self loadList];
}
- (void)onRefresh:(id)sender{
    [self loadList];
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}
-(void)loadList{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *auth = [userdefault stringForKey:@"auth"];
    NSString *userid = [userdefault stringForKey:@"userid"];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self WithAuthString:auth];
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
    [self.refreshControl endRefreshing];
    if ([request_type isEqualToString:@"WatchingList"]) {
        bgmlist = list;
        [self.tableView reloadData];
    }
    if ([request_type isEqualToString:@"updateProgress"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已成功标记为已看过～"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"了解"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self loadList];
    }
    if ([request_type isEqualToString:@"EPList"]) {
        NSInteger ep_countindex = ep_count - 1;
        if ([[list valueForKey:@"eps"] count] > 0 && ep_countindex <= [[list valueForKey:@"eps"] count]) {
            NSString *epid = [[[list valueForKey:@"eps"] objectAtIndex:ep_countindex] valueForKey:@"id"];
            NSLog(@"epidd:%@",epid);
            [bgmapi setProgressWithEPID:epid WithStatus:@"watched"];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            request_type = @"updateProgress";
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未知错误！"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"了解"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.refreshControl endRefreshing];
    
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
    cell.titlelabel.text = [arr valueForKey:@"name"];
    NSInteger ep_status = [[arr valueForKey:@"ep_status"] integerValue];//已看
    NSInteger eps = [[[arr valueForKey:@"subject"] valueForKey:@"eps"] integerValue];//总共
    
    [cell.updatebtn setTitle:[NSString stringWithFormat:@"标记 ep.%ld 看过",ep_status+1] forState:UIControlStateNormal];
    [cell.updatebtn addTarget:self action:@selector(updatebtnpressd:) forControlEvents:UIControlEventTouchUpInside];
    
    if (eps == 0) {
        cell.progresslabel.text = [NSString stringWithFormat:@"%ld/??",ep_status];
        //[cell.updatebtn setHidden:YES];
        if (ep_status <= 12) {
            eps = 12;
        }else{
            eps = 100;
        }
    }else if (eps == ep_status){
        cell.progresslabel.text = [NSString stringWithFormat:@"%ld/%ld",ep_status,eps];
        //[cell.updatebtn setHidden:YES];
    }else{
        cell.progresslabel.text = [NSString stringWithFormat:@"%ld/%ld",ep_status,eps];
        [cell.updatebtn setHidden:NO];
        
    }
    float i = ep_status;
    float f = eps;
    float percent = i/f;
    [cell.prgoressbar setProgress:percent animated:YES];
    
    
    NSString *iconurl = [[[arr valueForKey:@"subject"] valueForKey:@"images"] valueForKey:@"small"];
    [cell.icon setImageWithURL:[NSURL URLWithString:iconurl] placeholderImage:nil];
    
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

-(void)updatebtnpressd:(id)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        //NSLog(@"indexpath?:%ld",indexPath.row);
        NSUInteger row = [indexPath row];
        NSArray *arr = [bgmlist objectAtIndex:row];
        NSInteger ep_status = [[arr valueForKey:@"ep_status"] integerValue];//已看
        epid = [[arr valueForKey:@"subject"] valueForKey:@"id"];
        ep_count = ep_status+1;
        UIAlertView *updatealert = [[UIAlertView alloc] initWithTitle:@"确定将以下章节标为看过？"
                                                              message:[NSString stringWithFormat:@"%@ ep.%ld",[arr valueForKey:@"name"],ep_count]
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
                [bgmapi getEPListWithSubID:epid];
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                request_type = @"EPList";
            }
        }
    }
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathsForSelectedRows][0];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BGMDetailViewController *detailview = [segue destinationViewController];
    //NSLog(@"id:%@",[[[bgmlist objectAtIndex:indexPath.row] valueForKey:@"subject"] valueForKey:@"id"]);
    
    detailview.bgmid = [[[bgmlist objectAtIndex:indexPath.row] valueForKey:@"subject"] valueForKey:@"id"];
    detailview.bgmsummary.text = @"";
    detailview.titlelabel.text = @"";
    detailview.titlelabel_cn.text = @"";
    [detailview.progressmanabtn setHidden:YES];
}




@end

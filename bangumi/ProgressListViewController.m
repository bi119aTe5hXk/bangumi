//
//  ProgressListViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import "ProgressListViewController.h"

@interface ProgressListViewController ()

@end

@implementation ProgressListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}
-(void)getList{
    [bgmapi getProgressListWithUID:[userdefaults stringForKey:@"userid"] WithSubID:self.subid];
    request_type = @"getProgressList";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"观看进度";
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    //NSLog(@"list:%@",self.progresslist);
    //[self.tableView reloadData];
    [self getList];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void)onRefresh:(id)sender{
    [self getList];
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
    statuslist = [[NSMutableArray alloc] init];
    if ([request_type  isEqualToString: @"getProgressList"]) {
        NSArray *statusArr = [list valueForKey:@"eps"];
        
        
        for(int i = 0; i < self.progresslist.count; i++){
            NSArray *aep = [self.progresslist objectAtIndex:i];
           NSString *name_cn = @"null";
            
            
            for(NSArray *epsing in statusArr){
                if ([aep containsObject:[epsing valueForKey:@"id"]]) {
                    
                    name_cn = [[epsing valueForKey:@"status"] valueForKey:@"cn_name"];
                    [statuslist addObject:name_cn];
                    break;
                }
            }
            if ([name_cn  isEqualToString: @"null"]) {
                name_cn = @"未看";
                [statuslist addObject:name_cn];
            }
            
        }
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
//                       ^{
//                           //background thread code
//                           //[self performSelector:@selector(updatemethod:) withObject:nil];
//                           dispatch_async(dispatch_get_main_queue(),
//                                          ^{    //back on main thread
//                                              [self.tableView reloadData];
//                                          });});
        //dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        //});
        
    }
    if ([request_type isEqualToString:@"updateProgress"]) {
        
        if ([[list valueForKey:@"error"] isEqualToString:@"OK"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已成功记录"
                                                            message:[list valueForKey:@"error"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"了解"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"记录失败"
                                                            message:[list valueForKey:@"error"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"了解"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }
        [self getList];
    }
    
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [self.refreshControl endRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
////#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self.refreshControl endRefreshing];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.progresslist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgressCell";
    ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSInteger row = indexPath.row;
    
    // Configure the cell...
    
    NSArray *progressArr = [self.progresslist objectAtIndex:row];
    
    
    
    NSString *name_cn = [statuslist objectAtIndex:row];
    if ([name_cn  isEqualToString: @"想看"]) {
        [cell.sublabel setTextColor:[UIColor redColor]];
    }else if ([name_cn  isEqualToString: @"看过"]){
        [cell.sublabel setTextColor:[UIColor blueColor]];
    }else if ([name_cn  isEqualToString: @"在看"]){
        [cell.sublabel setTextColor:[UIColor greenColor]];
    }else if ([name_cn  isEqualToString: @"搁置"]){
        [cell.sublabel setTextColor:[UIColor grayColor]];
    }else if ([name_cn  isEqualToString: @"抛弃"]){
        [cell.sublabel setTextColor:[UIColor darkGrayColor]];
    }else{
        [cell.sublabel setTextColor:[UIColor grayColor]];
    }
    
    cell.sublabel.text = name_cn;
    
    
    
//    for(int i = 0; i < statuslist.count; i++){
//        NSArray *progressStatuesArr = [statuslist objectAtIndex:i];
//        
//        if () {
//            
//            NSLog(@"id1:%@,id2:%@",[progressStatuesArr valueForKey:@"id"],[progressArr valueForKey:@"id"]);
//            
//            
//            
//            
//            NSLog(@"wtf:%@,row:%ld，ep:%@",name_cn,(long)row,[progressArr valueForKey:@"sort"]);
//        }else{
//            NSLog(@"nil,row:%ld，ep:%@",(long)row,[progressArr valueForKey:@"sort"]);
//            cell.sublabel.text = @"未看";
//            [cell.sublabel setTextColor:[UIColor grayColor]];
//        }
//        
//    }
    
    

    
    cell.titlelabel.text = [HTMLEntityDecode htmlEntityDecode:[NSString stringWithFormat:@"ep.%@ %@",[progressArr valueForKey:@"sort"],[progressArr valueForKey:@"name"]]];
    
    cell.titlelabel.font = [UIFont systemFontOfSize:12.0f];
    cell.titlelabel.numberOfLines = 3;
    cell.sublabel.font = [UIFont systemFontOfSize:15.0f];
    cell.sublabel.lineBreakMode = NSLineBreakByWordWrapping;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectrow = indexPath.row;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改追番状态"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"保持不变"
                                          otherButtonTitles:@"看过",@"想看",@"抛弃",@"撤销",@"查看讨论串", nil];
    [alert setTag:233];
    [alert show];
}
-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 233) {
        if (buttonIndex >0) {
            NSString *epid = [[self.progresslist objectAtIndex:selectrow] valueForKey:@"id"];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            request_type = @"updateProgress";
            if(buttonIndex == 1){
                //看过
                [bgmapi setProgressWithEPID:epid WithStatus:@"watched"];
            }else if (buttonIndex == 2){
                //想看
                [bgmapi setProgressWithEPID:epid WithStatus:@"queue"];
            }else if (buttonIndex == 3){
                //抛弃
                [bgmapi setProgressWithEPID:epid WithStatus:@"drop"];
            }else if (buttonIndex == 4){
                //撤销
                [bgmapi setProgressWithEPID:epid WithStatus:@"remove"];
            }
            else if (buttonIndex == 5){
                //查看讨论串
                NSString *disscussurl = [NSString stringWithFormat:@"http://bgm.tv/m/topic/ep/%@",epid];
                [self showWebViewWithURL:disscussurl];
                
            }
            
        }
    }
}
-(void)showWebViewWithURL:(NSString *)url{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [self.refreshControl endRefreshing];
//    WebViewController *webview  = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
//    webview.urlstr = url;
//    webview.titlestr = @"条目讨论版";
//    [self.navigationController presentViewController:webview animated:YES completion:nil];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:url] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:YES completion:nil];
    
}
@end

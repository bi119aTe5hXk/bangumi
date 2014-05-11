//
//  ProgressListViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/11.
//  Copyright (c) 2014年 HT&L. All rights reserved.
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
    userdefaults = [NSUserDefaults standardUserDefaults];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    [bgmapi getProgressListWithUID:[userdefaults stringForKey:@"userid"] WithSubID:self.subid];
    request_type = @"getProgressList";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //NSLog(@"list:%@",self.progresslist);
    //[self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([request_type  isEqualToString: @"getProgressList"]) {
        statuslist = [list valueForKey:@"eps"];
        [self.tableView reloadData];
    }
    if ([request_type isEqualToString:@"updateProgress"]) {
        if ([[list valueForKey:@"error"] isEqualToString:@"OK"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已成功记录"
                                                            message:[list valueForKey:@"error"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"了解"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [bgmapi getProgressListWithUID:[userdefaults stringForKey:@"userid"] WithSubID:self.subid];
            request_type = @"getProgressList";
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"记录失败"
                                                            message:[list valueForKey:@"error"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"了解"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
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
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.progresslist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgressCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = indexPath.row;
    
    // Configure the cell...
    
    if (row <= self.progresslist.count) {
        NSArray *progressArr = [self.progresslist objectAtIndex:row];
        cell.textLabel.text = [HTMLEntityDecode htmlEntityDecode:[NSString stringWithFormat:@"ep.%@ %@",[progressArr valueForKey:@"sort"],[progressArr valueForKey:@"name"]]];
        
    }else{
        cell.textLabel.text = @"";
    }
    
    if (row < statuslist.count) {
        NSArray *progressStatuesArr = [statuslist objectAtIndex:row];
        if ([[progressStatuesArr valueForKey:@"status"] valueForKey:@"id"] == [NSNumber numberWithInteger:1]) {
            cell.detailTextLabel.text = @"想看";
            [cell.detailTextLabel setTextColor:[UIColor redColor]];
        }else if ([[progressStatuesArr valueForKey:@"status"] valueForKey:@"id"] == [NSNumber numberWithInteger:2]){
            cell.detailTextLabel.text = @"看过";
            [cell.detailTextLabel setTextColor:[UIColor blueColor]];
        }else if ([[progressStatuesArr valueForKey:@"status"] valueForKey:@"id"] == [NSNumber numberWithInteger:3]){
            cell.detailTextLabel.text = @"在看";
            [cell.detailTextLabel setTextColor:[UIColor greenColor]];
        }else if ([[progressStatuesArr valueForKey:@"status"] valueForKey:@"id"] == [NSNumber numberWithInteger:4]){
            cell.detailTextLabel.text = @"搁置";
            [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        }else if ([[progressStatuesArr valueForKey:@"status"] valueForKey:@"id"] == [NSNumber numberWithInteger:5]){
            cell.detailTextLabel.text = @"抛弃";
            [cell.detailTextLabel setTextColor:[UIColor darkGrayColor]];
        }else{
            cell.detailTextLabel.text = @"";
            [cell.detailTextLabel setTextColor:[UIColor grayColor]];
        }
    }else{
        cell.detailTextLabel.text = @"";
        [cell.detailTextLabel setTextColor:[UIColor grayColor]];
    }
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.numberOfLines = 3;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
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
                                          otherButtonTitles:@"看过",@"想看",@"抛弃",@"撤销", nil];
    [alert setTag:233];
    [alert show];
}
-(void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 233) {
        if (buttonIndex >0) {
            NSString *epid = [[self.progresslist objectAtIndex:selectrow] valueForKey:@"id"];
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
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            request_type = @"updateProgress";
        }
    }
}
@end

//
//  DaliyListViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/30.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "DaliyListViewController.h"

@interface DaliyListViewController ()

@end

@implementation DaliyListViewController

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
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self WithAuthString:[userdefaults stringForKey:@"auth_urlencoded"]];
    //[bgmapi getDayBGMList];
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)onRefresh:(id)sender{
    [bgmapi getDayBGMList];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}
-(void)viewDidAppear:(BOOL)animated{
    if (daylist.count <= 0) {
        userdefaults = [NSUserDefaults standardUserDefaults];
        bgmapi = [[BGMAPI alloc] initWithdelegate:self WithAuthString:[userdefaults stringForKey:@"auth_urlencoded"]];
        [bgmapi getDayBGMList];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.refreshControl endRefreshing];
    daylist = list;
    [self.tableView reloadData];
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [daylist count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[[daylist objectAtIndex:section] objectForKey:@"items"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayCell" forIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    NSArray *arr = daylist[indexPath.section][@"items"][row];
    
    cell.titlelabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name"]];
    cell.sublabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name_cn"]];
    [cell.icon setImageWithURL:[[arr valueForKey:@"images"] valueForKey:@"grid"]];
    //[cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

-(UIView *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[[daylist objectAtIndex:section] valueForKey:@"weekday"] valueForKey:@"cn"];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BGMDetailViewController *detailview = [self.storyboard instantiateViewControllerWithIdentifier:@"BGMDetailViewController"];
    detailview.bgmid = [daylist[indexPath.section][@"items"][indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:detailview animated:YES];
}
@end

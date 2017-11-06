//
//  SettingsViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    

}
-(void)viewWillAppear:(BOOL)animated{
    //self.creditText.text = @"WebSite/API: @Sai \nDeveloper: @bi119aTe5hXk \nIcon: @cinnamor";
    self.tabBarController.navigationItem.title = @"设置";
    
    userdefault = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    [bgmapi getNotifyCount];
    if (debugmode == YES) {
        NSLog(@"START GET NOTIFY COUNT");
    }
}
-(IBAction)openRakuen:(id)sender{
//    self.webview = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
//    self.webview.urlstr = rakuenURL;
//    self.webview.titlestr = @"超展开 Mobile";
//    [self.navigationController presentViewController:self.webview animated:YES completion:nil];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:rakuenURL] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:YES completion:nil];
}
-(IBAction)logout:(id)sender{
    [userdefault setObject:nil forKey:@"auth_urlencoded"];
    [userdefault setObject:nil forKey:@"auth"];
    [userdefault setObject:nil forKey:@"userid"];
    [userdefault synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [bgmapi cancelConnection];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    NSString *count = [NSString stringWithFormat:@"%@",[list valueForKey:@"count"]];
    if ([count integerValue] >= 1) {
        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%@",[list valueForKey:@"count"]]];
        [self.rakuenbtn setTitle:[NSString stringWithFormat:@"超展开: %@条新信息",[list valueForKey:@"count"]] forState:UIControlStateNormal];
    }else{
        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
        [self.rakuenbtn setTitle:@"超展开 Mobile" forState:UIControlStateNormal];
    }
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
////#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
////#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 1;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        UILabel *myLabel = [[UILabel alloc] init];
//        myLabel.frame = CGRectMake(20, 8, 320, 20);
//        myLabel.font = [UIFont boldSystemFontOfSize:18];
//        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
//        
//        UIView *headerView = [[UIView alloc] init];
//        [headerView addSubview:myLabel];
//        
//        return headerView;
//    }
//    
//    
//    
//    
//    
//}


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

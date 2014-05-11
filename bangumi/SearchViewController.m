//
//  SearchViewController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/05/04.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    userdefaults = [NSUserDefaults standardUserDefaults];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self WithAuthString:[userdefaults stringForKey:@"auth_urlencoded"]];
    //[self.tableView registerClass: [NormalCell class] forCellReuseIdentifier:@"SearchCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [bgmapi cancelConnection];
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    resultlist = list;
    [self.tableView reloadData];
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSInteger count = [[resultlist valueForKey:@"list"] count];
    if (count == 20) {
        return [[resultlist valueForKey:@"list"] count] + 1;
    }else{
        return [[resultlist valueForKey:@"list"] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    static NSString *CellIdentifier = @"SearchCell";
    NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    
    if (row == [[resultlist valueForKey:@"list"] count]) {
        cell.titlelabel.text = [resultlist valueForKey:@"results"];
        cell.sublabel.text = @"";
        cell.icon.image = nil;
    }else{
        NSArray *arr = [[resultlist valueForKey:@"list"] objectAtIndex:row];
        cell.titlelabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name"]];
        cell.sublabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name_cn"]];
        [cell.icon setImageWithURL:[[arr valueForKey:@"images"] valueForKey:@"grid"]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
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
    detailview.bgmid = [[[resultlist valueForKey:@"list"] objectAtIndex:indexPath.row] valueForKey:@"id"];
    [self.navigationController pushViewController:detailview animated:YES];
}

#pragma mark Search Bar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
	return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	if ([searchText length] > 0){
        
	}else{
        resultlist = nil;
        resultlist = [[NSArray alloc] init];
        [self.tableView reloadData];
        [searchBar setShowsCancelButton:YES animated:YES];
        //isLoading = NO;
        [bgmapi cancelConnection];
		//[searchBar resignFirstResponder];
	}
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
	[searchBar resignFirstResponder];
    if ([searchBar.text length] != 0){
        //start search
        
        //resultlist = nil;
        resultlist = [[NSArray alloc] init];
        [self.tableView reloadData];
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [bgmapi searchWithKeyword:searchBar.text startWithCount:0];
    }
}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    if ([searchBar.text length] != 0) {
        //page = 1;
        [bgmapi cancelConnection];
        resultlist = [[NSArray alloc] init];
        [self.tableView reloadData];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [bgmapi searchWithKeyword:searchBar.text startWithCount:0];
    }
}

@end

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
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title  = @"搜索";
    
    // Info button
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(searchinfo:) forControlEvents:UIControlEventTouchUpInside];
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    //UIBarButtonItem *helpbtn = [[UIBarButtonItem alloc] initWithTitle:@"？" style:UIBarButtonItemStyleDone target:self action:@selector(searchinfo:)];
    
    //self.tabBarController.navigationItem.rightBarButtonItem = helpbtn;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.navigationItem.title  = @"搜索";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    bgmapi = [[BGMAPI alloc] initWithdelegate:self ];
    //[self.tableView registerClass: [NormalCell class] forCellReuseIdentifier:@"SearchCell"];
}
-(IBAction)searchinfo:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于搜索"
                                                    message:@"目前暂时只能搜索动画以及显示前20条结果，如果找不到您想看的番组，请将关键词描写更详细一些。谢谢m(_ _)m"
                                                   delegate:nil
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    [bgmapi cancelConnection];
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([list valueForKey:@"list"] != [NSNull null]) {
        resultlist = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });
    }else{
        [self noresult];
    }
    
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    [self noresult];
    
}
-(void)noresult{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无结果"
                                                        message:@"换个关键词试试？"
                                                       delegate:nil
                                              cancelButtonTitle:@"好的"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    NSInteger count = [[resultlist valueForKey:@"list"] count];
//    if (count == 20) {
//        return [[resultlist valueForKey:@"list"] count] + 1;
//    }else{
        return [[resultlist valueForKey:@"list"] count];
//    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    static NSString *CellIdentifier = @"SearchCell";
    NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger row = [indexPath row];
    
    if (row == [[resultlist valueForKey:@"list"] count]+1) {
        cell.titlelabel.text = @"下一页";
        cell.sublabel.text = @"";
        cell.icon.image = nil;
    }else{
        NSArray *arr = [[resultlist valueForKey:@"list"] objectAtIndex:row];
        cell.titlelabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name"]];
        cell.sublabel.text = [HTMLEntityDecode htmlEntityDecode:[arr valueForKey:@"name_cn"]];
        //[cell.icon setImageWithURL:];
        
        
        if ([arr valueForKey:@"images"] != [NSNull null]) {
            NSString *imgurlstr =[[arr valueForKey:@"images"] valueForKey:@"grid"];
            
            //NSLog(@"imageurlstr:%@",imgurlstr);
            if (imgurlstr.length > 0) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgurlstr]];
                    if (imgData) {
                        UIImage *image = [UIImage imageWithData:imgData];
                        if (image) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [cell.icon setImage:image];
                            });
                        }
                    }
                });
            }
            
        }else{
            [cell.icon setImage:[UIImage imageNamed:@"bgm38a1024.png"]];
        }
        
        
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}




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
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
//        BGMDetailViewController *detailview = [self.storyboard instantiateViewControllerWithIdentifier:@"BGMDetailViewController"];
//        detailview.bgmidstr = [[[resultlist valueForKey:@"list"] objectAtIndex:indexPath.row] valueForKey:@"id"];
//        [self.navigationController pushViewController:detailview animated:YES];
//    }
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    BGMDetailViewController *detailview = (BGMDetailViewController *)[[segue destinationViewController] topViewController] ;
    NSString *bgmid = [[[[resultlist valueForKey:@"list"] objectAtIndex:indexPath.row] valueForKey:@"id"] stringValue];
    [detailview startGetSubjectInfoWithID:bgmid];
    detailview.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    detailview.navigationItem.leftItemsSupplementBackButton = YES;
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [searchBar setShowsCancelButton:YES animated:YES];
            //isLoading = NO;
            [bgmapi cancelConnection];
            //[searchBar resignFirstResponder];

        });
        
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
	[searchBar resignFirstResponder];
    if ([searchBar.text length] != 0){
        //start search
        
        //resultlist = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            resultlist = [[NSArray alloc] init];
            [self.tableView reloadData];
            
            
            //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [bgmapi searchWithKeyword:searchBar.text startWithCount:0];
        });
        
    }
}
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    if ([searchBar.text length] != 0) {
        //page = 1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [bgmapi cancelConnection];
            resultlist = [[NSArray alloc] init];
            [self.tableView reloadData];
            //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [bgmapi searchWithKeyword:searchBar.text startWithCount:0];
        });
        
    }
}

@end

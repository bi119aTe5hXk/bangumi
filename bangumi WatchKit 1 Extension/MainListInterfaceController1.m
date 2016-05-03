//
//  MainListInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import "MainListInterfaceController1.h"

@interface MainListInterfaceController1 ()

@end

@implementation MainListInterfaceController1

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    
    [userdefaults synchronize];
    
    
    auth = [userdefaults stringForKey:@"auth"];
    //NSLog(@"watchauth1:%@",auth);
    if ([auth length] == 0) {
        
        [self presentControllerWithName:@"NotLoginInterfaceController1" context:NULL];
    }else{
        //start to load list
        bgmapi = [[BGMAPI alloc] initWithdelegate:self];
        NSString *userid = [userdefaults stringForKey:@"userid"];
        [bgmapi getWatchingListWithUID:userid];
        
    }
}

- (void)didDeactivate {
    [bgmapi cancelConnection];
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    //daylist = [[list objectAtIndex:day] valueForKey:@"items"];
    //NSLog(@"daylist:%@",daylist);
    bgmlist = list;
    
    [self.tableview setNumberOfRows:[list count] withRowType:@"default"];
    NSInteger rowCount = self.tableview.numberOfRows;
    for (NSInteger i = 0; i < rowCount; i++) {
        NSString *itemText = [HTMLEntityDecode htmlEntityDecode:[[list objectAtIndex:i] valueForKey:@"name"]];
        
        BGMWKCell* row = [self.tableview rowControllerAtIndex:i];
        [row.wk_title setText:itemText];
        
        if ([[[list objectAtIndex:i] valueForKey:@"subject"] valueForKey:@"images"]  != [NSNull null]) {
            NSString *imageURL = [[[[list objectAtIndex:i] valueForKey:@"subject"] valueForKey:@"images"] valueForKey:@"grid"];
            [row.wk_icon setImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
        }
        
    }
    
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex{
    
//    DetailWKInterfaceController *detailview = [segue destinationViewController];
//    
//    NSString *bgmids = [[[bgmlist objectAtIndex:rowIndex] valueForKey:@"subject"] valueForKey:@"id"];
    return [bgmlist objectAtIndex:rowIndex];
}


@end




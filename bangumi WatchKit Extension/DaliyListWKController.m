//
//  DaliyListWKController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import "DaliyListWKController.h"

@interface DaliyListWKController ()

@end

@implementation DaliyListWKController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    api = [[BGMAPI alloc] initWithdelegate:self];
    [api getDayBGMList];
}

- (void)didDeactivate {
    [api cancelConnection];
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    //daylist = list;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierJapanese];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger weekday = [comps weekday];
    //NSLog(@"weekday:%ld",weekday);
    NSInteger day=0;
    if (weekday == 1) {
        //sun
        day=6;
    }else if(weekday ==2){
        //mon
        day = 0;
    }else if(weekday ==3){
        //tue
        day = 1;
    }else if(weekday ==4){
        //wen
        day = 2;
    }else if(weekday ==5){
        //tur
        day = 3;
    }else if(weekday ==6){
        //fri
        day = 4;
    }else if(weekday ==7){
        //sat
        day = 5;
    }
    //NSLog(@"day:%ld",day);
    daylist = [[list objectAtIndex:day] valueForKey:@"items"];
    //NSLog(@"daylist:%@",daylist);
    
    [self.tableview setNumberOfRows:[daylist count] withRowType:@"default"];
    NSInteger rowCount = self.tableview.numberOfRows;
    
    for (NSInteger i = 0; i < rowCount; i++) {
    NSString *itemText = [HTMLEntityDecode htmlEntityDecode:[[daylist objectAtIndex:i] valueForKey:@"name"]];
    NSString *imageURL = [[[daylist objectAtIndex:i] valueForKey:@"images"] valueForKey:@"grid"];
    BGMWKCell* row = [self.tableview rowControllerAtIndex:i];
    [row.wk_title setText:itemText];
    [row.wk_icon setImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    }
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    
}
@end




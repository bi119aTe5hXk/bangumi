//
//  StatusChangeInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2017/10/04.
//  Copyright © 2017 @bi119aTe5hXkL. All rights reserved.
//

#import "StatusChangeInterfaceController.h"

@interface StatusChangeInterfaceController ()

@end

@implementation StatusChangeInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if (debugmode == YES) {
        NSLog(@"context:%@",context);
    }
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    bgmid = context;
    // Configure interface objects here.
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [bgmapi cancelConnection];
    [super didDeactivate];
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    [self dismissController];
}
-(IBAction)wantBTN:(id)sender{
    [bgmapi setCollectionWithColID:bgmid WithRating:0 WithStatus:@"wish"];
    [self setAlltoWait];
}
-(IBAction)wingBTN:(id)sender{
    [bgmapi setCollectionWithColID:bgmid WithRating:0 WithStatus:@"do"];
    [self setAlltoWait];
}
-(IBAction)wedBTN:(id)sender{
    [bgmapi setCollectionWithColID:bgmid WithRating:0 WithStatus:@"collect"];
    [self setAlltoWait];
}
-(IBAction)wlaterBTN:(id)sender{
    [bgmapi setCollectionWithColID:bgmid WithRating:0 WithStatus:@"on_hold"];
    [self setAlltoWait];
}
-(IBAction)trashBTN:(id)sender{
    [bgmapi setCollectionWithColID:bgmid WithRating:0 WithStatus:@"dropped"];
    [self setAlltoWait];
}
-(IBAction)cancelBTN:(id)sender{
    [self dismissController];
}
-(void)setAlltoWait{
    [self.wantBTN setTitle:@"更新中..."];
    [self.wantBTN setEnabled:NO];
    [self.wingBTN setTitle:@"更新中..."];
    [self.wingBTN setEnabled:NO];
    [self.wedBTN setTitle:@"更新中..."];
    [self.wedBTN setEnabled:NO];
    [self.wlaterBTN setTitle:@"更新中..."];
    [self.wlaterBTN setEnabled:NO];
    [self.trashBTN setTitle:@"更新中..."];
    [self.trashBTN setEnabled:NO];
}
@end




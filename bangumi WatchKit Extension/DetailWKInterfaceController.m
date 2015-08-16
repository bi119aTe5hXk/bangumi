//
//  DetailWKInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/17.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import "DetailWKInterfaceController.h"

@interface DetailWKInterfaceController ()

@end

@implementation DetailWKInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSLog(@"context:%@",context);
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    [self.title_org setText:[HTMLEntityDecode htmlEntityDecode:[[context valueForKey:@"subject"] valueForKey:@"name"]]];
    [self.title_cn setText:[HTMLEntityDecode htmlEntityDecode:[[context valueForKey:@"subject"] valueForKey:@"name_cn"]]];
    NSString *iconurl = [[[context valueForKey:@"subject"] valueForKey:@"images"] valueForKey:@"common"];
    [self.imageview setImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl]]];
    
    NSInteger ep_status = [[context valueForKey:@"ep_status"] integerValue];//已看
    NSInteger eps = [[[context valueForKey:@"subject"] valueForKey:@"eps"] integerValue];//总共

    [self.watchedbtn setTitle:[NSString stringWithFormat:@"标记 ep.%ld 看过",(long)ep_status+1]];
    if (eps == 0) {
        [self.progresslabel setText:[NSString stringWithFormat:@"%ld/??",(long)ep_status]];
        //[cell.updatebtn setHidden:YES];
        if (ep_status <= 12) {
            eps = 12;
        }else{
            eps = 100;
        }
    }else if (eps == ep_status){
        [self.progresslabel setText:[NSString stringWithFormat:@"%ld/%ld",(long)ep_status,(long)eps]];
        //[cell.updatebtn setHidden:YES];
    }else{
        [self.progresslabel setText:[NSString stringWithFormat:@"%ld/%ld",(long)ep_status,(long)eps]];
        //[cell.updatebtn setHidden:NO];
        
    }
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [bgmapi cancelConnection];
    [super didDeactivate];
    
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    
}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    
}
-(IBAction)backbtn:(id)sender{
    [bgmapi cancelConnection];
    [self dismissController];
    
}
-(IBAction)watchedbtn:(id)sender{
    
}
@end




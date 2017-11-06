//
//  DetailWKInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/17.
//  Copyright (c) 2015年 bi119aTe5hXk. All rights reserved.
//

#import "DetailWKInterfaceController.h"

@interface DetailWKInterfaceController ()

@end

@implementation DetailWKInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if (context == nil) {
        [self dismissController];
    }
    
    
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    [bgmapi cancelConnection];
    //NSLog(@"context:%@",context);
    //detailarr = context;
    bgmid = context;
    
    
    [bgmapi getSubjectInfoWithSubID:bgmid];
    request_type = @"loaddetail";
    
}




- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    bgmapi = [[BGMAPI alloc] initWithdelegate:self];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [bgmapi cancelConnection];
    [super didDeactivate];
    
}
-(void)api:(BGMAPI *)api readyWithList:(NSArray *)list{
    if ([request_type isEqualToString:@"EPList"]) {
        NSInteger ep_countindex = ep_count -1;
        if ([[list valueForKey:@"eps"] count] > 0 && ep_countindex <= [[list valueForKey:@"eps"] count]) {
            
            //remove sp
            NSArray *arr = [list valueForKey:@"eps"];
            NSArray *newlist = [NSArray array];
            for (int i=0; i<[arr count]; i++) {
                
                if ([[[arr objectAtIndex:i] valueForKey:@"type"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    newlist = [newlist arrayByAddingObject:[arr objectAtIndex:i]];
                }else{
                    
                }
            }
            
            NSString *epid = [[newlist objectAtIndex:ep_countindex] valueForKey:@"id"];
            //NSLog(@"epidd:%@",epid);
            [bgmapi setProgressWithEPID:epid WithStatus:@"watched"];
            request_type = @"updateProgress";
        }
        
    }
    if ([request_type isEqualToString:@"updateProgress"]) {
        if ([[list valueForKey:@"error"] isEqualToString:@"OK"]) {
            [self dismissController];
        }else{
            [self dismissController];
        }
        
    }
    if([request_type isEqualToString:@"loaddetail"]){
        [self.title_org setText:[HTMLEntityDecode htmlEntityDecode:[list valueForKey:@"name"]]];
        [self.title_cn setText:[HTMLEntityDecode htmlEntityDecode:[list valueForKey:@"name_cn"]]];
        
        if ([list valueForKey:@"images"] != [NSNull null]) {
            NSString *iconurl = [[list valueForKey:@"images"] valueForKey:@"common"];
            //[self.imageview setImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconurl]]];
            
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session             = [NSURLSession sessionWithConfiguration:config];
            
            NSURLSessionDownloadTask *imageDownloadTask = [session downloadTaskWithURL:[NSURL URLWithString:iconurl] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                //NSLog(@"download complate : %@", imageName);
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.imageview setImage:downloadedImage];
                });
            }];
            [imageDownloadTask resume];
        }
        
        
        
        
//        NSInteger ep_status = [[list valueForKey:@"ep_status"] integerValue];//已看
//        NSInteger eps = [[list valueForKey:@"eps"] integerValue];//总共
//        ep_count = ep_status+1;
//
//        [self.watchedbtn setTitle:[NSString stringWithFormat:@"标记 ep.%ld 看过",(long)ep_status+1]];
//
//        if (eps <= 0) {
//
//            //[cell.updatebtn setHidden:YES];
//            //        if (ep_status <= 12) {
//            //            eps = 12;
//            //        }else{
//            //            eps = 100;
//            //        }
//            [self.progresslabel setText:[NSString stringWithFormat:@"%ld/??",(long)ep_status]];
//
//
//        }else if (eps == ep_status){
//            [self.progresslabel setText:[NSString stringWithFormat:@"%ld/%ld",(long)ep_status,(long)eps]];
//            //[cell.updatebtn setHidden:YES];
//        }else{
//            [self.progresslabel setText:[NSString stringWithFormat:@"%ld/%ld",(long)ep_status,(long)eps]];
//            //[cell.updatebtn setHidden:NO];
//
//        }
        
        if ([list valueForKey:@"eps"] != [NSNull null]) {
            NSArray *arr = [list valueForKey:@"eps"];
            NSArray *newlist = [NSArray array];
            for (int i=0; i<[arr count]; i++) {
                
                if ([[[arr objectAtIndex:i] valueForKey:@"type"] isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    newlist = [newlist arrayByAddingObject:[arr objectAtIndex:i]];
                }else{
                    
                }
            }
            
            detailarr = newlist;
        }else{
            detailarr = [NSArray array];
        }
    }

}
-(void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error{
    [self dismissController];
}
-(IBAction)backbtn:(id)sender{
    [bgmapi cancelConnection];
    [self dismissController];
    
}
-(IBAction)watchedbtn:(id)sender{
    NSString *epid = [detailarr valueForKey:@"id"];
    [bgmapi getEPListWithSubID:epid];
    request_type = @"EPList";
}
-(IBAction)setBGMStatus:(id)sender{
    
}
@end




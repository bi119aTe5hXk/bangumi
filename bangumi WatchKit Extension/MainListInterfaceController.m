//
//  MainListInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 bi119aTe5hXk. All rights reserved.
//

#import "MainListInterfaceController.h"

@interface MainListInterfaceController ()

@end

@implementation MainListInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}


-(void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSLog(@"New Session Context: %@", applicationContext);
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    
    for (NSString *key in applicationContext.allKeys) {
        [defaults setObject:[applicationContext objectForKey:key] forKey:key];
    }
    
    [defaults synchronize];
    [self checkauth];
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error { 
    
}



- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    
    [userdefaults synchronize];
    
    [self checkauth];
    
}
-(void)checkauth{
    auth = [userdefaults stringForKey:@"auth"];
    if (debugmode == YES) {
        NSLog(@"watchauth2:%@",auth);
    }
    
    if ([auth length] <= 0) {
        
        [self presentControllerWithName:@"NotLoginInterfaceController" context:NULL];
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
            
            //[row.wk_icon setImageData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
            
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session             = [NSURLSession sessionWithConfiguration:config];
            
            NSURLSessionDownloadTask *imageDownloadTask = [session downloadTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                //NSLog(@"download complate : %@", imageName);
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [row.wk_icon setImage:downloadedImage];
                });
            }];
            [imageDownloadTask resume];
        }
        
    }
    
}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex{
    [bgmapi cancelConnection];
//    DetailWKInterfaceController *detailview = [segue destinationViewController];
//    
    //NSString *bgmids = [[[bgmlist objectAtIndex:rowIndex] valueForKey:@"subject"] valueForKey:@"id"];
    
    return [bgmlist objectAtIndex:rowIndex];
}
-(IBAction)updatebtn:(id)sender{
    [self checkauth];
}

@end




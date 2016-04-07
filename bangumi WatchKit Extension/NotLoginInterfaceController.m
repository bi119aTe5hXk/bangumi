//
//  NotLoginInterfaceController.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import "NotLoginInterfaceController.h"

@interface NotLoginInterfaceController ()

@end

@implementation NotLoginInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self setTitle:@" "];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
   
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *,id> *)applicationContext {
    NSLog(@"New Session Context: %@", applicationContext);
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    
    for (NSString *key in applicationContext.allKeys) {
        [defaults setObject:[applicationContext objectForKey:key] forKey:key];
    }
    
    [defaults synchronize];
    
    [self dismissController];
}

@end




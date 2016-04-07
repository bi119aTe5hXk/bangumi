//
//  DaliyListWKController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 HT&L. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "BGMAPI.h"
#import "BGMWKCell.h"
#import "HTMLEntityDecode.h"
@interface DaliyListWKController : WKInterfaceController<BGMAPIDelegate>{
    NSArray *daylist;
    BGMAPI *api;
    
    NSDictionary   *_imageNameDict;
}
@property (nonatomic, strong) IBOutlet WKInterfaceTable *tableview;

@end

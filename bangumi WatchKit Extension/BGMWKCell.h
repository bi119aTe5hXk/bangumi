//
//  BGMWKCell.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2015/08/16.
//  Copyright (c) 2015年 bi119aTe5hXk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
@interface BGMWKCell : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceImage *wk_icon;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *wk_title;
@end

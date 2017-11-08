//
//  StatusChangeInterfaceController.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2017/10/04.
//  Copyright © 2017 @bi119aTe5hXkL. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "BGMAPI.h"
@interface StatusChangeInterfaceController : WKInterfaceController<BGMAPIDelegate>{
    BGMAPI *bgmapi;
    NSString *bgmid;
}
//@property (nonatomic, strong) NSString *bgmid;
//@property (nonatomic, strong) IBOutlet WKInterfaceTable *tableview;

@property (nonatomic, strong) IBOutlet WKInterfaceButton *wantBTN;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *wingBTN;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *wedBTN;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *wlaterBTN;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *trashBTN;
@property (nonatomic, strong) IBOutlet WKInterfaceButton *cancelBTN;
-(IBAction)wantBTN:(id)sender;
-(IBAction)wingBTN:(id)sender;
-(IBAction)wedBTN:(id)sender;
-(IBAction)wlaterBTN:(id)sender;
-(IBAction)trashBTN:(id)sender;
-(IBAction)cancelBTN:(id)sender;

@end

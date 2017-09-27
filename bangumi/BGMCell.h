//
//  BGMCell.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/18.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGMCell : UITableViewCell

@property (nonatomic ,retain) IBOutlet UILabel *titlelabel;
@property (nonatomic ,retain) IBOutlet UIImageView *icon;
@property (nonatomic ,retain) IBOutlet UILabel *progresslabel;
@property (nonatomic ,retain) IBOutlet UIButton *updatebtn;
@property (nonatomic ,retain) IBOutlet UIProgressView *prgoressbar;


@end

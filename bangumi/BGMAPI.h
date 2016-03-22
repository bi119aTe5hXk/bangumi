//
//  BGMAPI.h
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/17.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "API.h"
@class BGMAPI;
@protocol BGMAPIDelegate
@optional
- (void)api:(BGMAPI *)api readyWithList:(NSArray *)list;
- (void)api:(BGMAPI *)api requestFailedWithError:(NSError *)error;
@end

@interface BGMAPI : NSObject<NSURLSessionDelegate>{
    NSUserDefaults *userdefaults;
    NSString *authString;
    NSString *authURLencoded;
    NSURLSession* urlsession;
    NSMutableData *responseData;
    NSURLSessionDataTask *task;
}
-(BGMAPI *)initWithdelegate:(NSObject <BGMAPIDelegate> *)delegate;

-(void)userLoginWithUserName:(NSString *)username WithPassword:(NSString *)password;

-(void)getWatchingListWithUID:(NSString *)uid;
-(void)getProgressListWithUID:(NSString *)uid WithSubID:(NSString *)subid;
-(void)getEPListWithSubID:(NSString *)subid;

-(void)getSubjectInfoWithSubID:(NSString *)subid;
-(void)getCollectionInfoWithColID:(NSString *)colid;

-(void)setCollectionWithColID:(NSString *)colid WithRating:(NSString *)rating WithStatus:(NSString *)status;
-(void)setProgressWithEPID:(NSString *)epid WithStatus:(NSString *)status;

-(void)getDayBGMList;

-(void)searchWithKeyword:(NSString *)keyword startWithCount:(NSInteger)count;

-(void)getNotifyCount;

- (void)cancelConnection;
@end

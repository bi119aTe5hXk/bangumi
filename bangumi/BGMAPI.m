//
//  BGMAPI.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/17.
//  Copyright (c) 2014年 bi119aTe5hXk. All rights reserved.
//

#import "BGMAPI.h"
#define settimeout 50
@interface BGMAPI ()
@property (assign, nonatomic) NSObject <BGMAPIDelegate> *delegate;


-(BOOL)createPOSTConnectionWithURL:(NSString *)urlstr WithPOSTData:(NSDictionary *)post_data;
- (BOOL)createGETConnectionWithURL:(NSString *)urlstr;

@end
@implementation NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String {
    return (id)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(0, (CFStringRef)self, 0,
                                                       (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8));
}

@end
@implementation BGMAPI
-(BGMAPI *)initWithdelegate:(NSObject <BGMAPIDelegate> *)delegate{
    self = [super init];
    
    userdefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];
    authString = [userdefaults stringForKey:@"auth"];
    authURLencoded = [userdefaults stringForKey:@"auth_urlencoded"];
    self.delegate = delegate;
    
    
    
    
    
    

    
    
    return self;
}


-(void)userLoginWithUserName:(NSString *)username WithPassword:(NSString *)password{
    NSString *url = [NSString stringWithFormat:PostLoginURL];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@",appName]];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",password,@"password", nil];
    [self createPOSTConnectionWithURL:url WithPOSTData:dic];
    
    //NSString *keyEncoded = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)username,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",kCFStringEncodingUTF8);
    //[self createGETConnectionWithURL:[[NSString stringWithFormat:BaseLoginURL,keyEncoded,password] stringByAppendingString:[NSString stringWithFormat:@"?source=%@",appName]]];
}

-(void)getWatchingListWithUID:(NSString *)uid{
    NSString *url = [NSString stringWithFormat:WatchingListURL,uid];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&source=%@&auth=%@",appName,authURLencoded]];
    [self createGETConnectionWithURL:url];
}
-(void)getProgressListWithUID:(NSString *)uid WithSubID:(NSString *)subid{
    NSString *url = [NSString stringWithFormat:ProgressListURL,uid,subid];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"&source=%@&auth=%@",appName,authURLencoded]];
    [self createGETConnectionWithURL:url];
}
-(void)getEPListWithSubID:(NSString *)subid{
    NSString *url = [NSString stringWithFormat:SubjectEPlistURL,subid];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@",appName,authURLencoded]];
     [self createGETConnectionWithURL:url];
}
-(void)getSubjectInfoWithSubID:(NSString *)subid{
    NSString *url = [NSString stringWithFormat:SubjectInfoURL,subid];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@&responseGroup=large",appName,authString]];
    [self createGETConnectionWithURL:url];
}
-(void)getCollectionInfoWithColID:(NSString *)colid{
    NSString *url = [NSString stringWithFormat:CollectionInfoURL,colid];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@",appName,authURLencoded]];
    [self createGETConnectionWithURL:url];
}

-(void)setCollectionWithColID:(NSString *)colid WithRating:(NSString *)rating WithStatus:(NSString *)status{
    NSString *url = @"";
    if ([status isEqualToString:@"do"]) {
        url = [NSString stringWithFormat:setCollectionURL,colid,@"create"];
    }else{
        url = [NSString stringWithFormat:setCollectionURL,colid,@"update"];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:authString,@"auth",status,@"status",rating,@"rating", nil];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&status=%@&auth=%@",appName,status,authURLencoded]];
    [self createPOSTConnectionWithURL:url WithPOSTData:dic];
    
}
-(void)setProgressWithEPID:(NSString *)epid WithStatus:(NSString *)status{
    NSString *url = [NSString stringWithFormat:setProgressURL,epid,status];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:authString,@"auth",epid,@"ep_id", nil];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@",appName,authURLencoded]];
    [self createPOSTConnectionWithURL:url WithPOSTData:dic];
}

-(void)getDayBGMList{
    NSString *url = dayBGMListURL;
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@",appName,authURLencoded]];
    [self createGETConnectionWithURL:url];
}
-(void)searchWithKeyword:(NSString *)keyword startWithCount:(NSInteger)count{
    NSString *keyEncoded = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)keyword,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",kCFStringEncodingUTF8);
    NSString *url = [NSString stringWithFormat:SearchURL,keyEncoded];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?type=2&source=%@&auth=%@&start=%ld&max_results=20",appName,authURLencoded,(long)count]];
    [self createGETConnectionWithURL:url];
}

-(void)getNotifyCount{
    NSString *url = notifyURL;
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@",appName,authURLencoded]];
    [self createGETConnectionWithURL:url];
}
#pragma mark - NSURLConnection
-(BOOL)createPOSTConnectionWithURL:(NSString *)urlstr WithPOSTData:(NSDictionary *)post_data{
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    [self cancelConnection];
    if (debugmode == YES) {
        NSLog(@"POSTURL: %@",url);
    }
    
    
    
    
    NSMutableString *body = [NSMutableString string];
    for (NSString *key in post_data) {
        NSString *val = [post_data objectForKey:key];
        if ([body length])
            [body appendString:@"&"];
        [body appendFormat:@"%@=%@", [[key description] urlEncodedUTF8String],
         [[val description] urlEncodedUTF8String]];
    }
    
    
    if (debugmode == YES) {
        NSLog(@"Post Data: %@",body);
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                  timeoutInterval:settimeout];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPShouldHandleCookies:YES];
    
#if TARGET_OS_IPHONE
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
#endif
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlsession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    task = [urlsession dataTaskWithRequest:request];
    [task resume];
    
    
    
    
     return YES;
}


- (BOOL)createGETConnectionWithURL:(NSString *)urlstr{
    NSURL *url = [NSURL URLWithString:urlstr];
    
    [self cancelConnection];
    if (debugmode == YES) {
        NSLog(@"GETURL: %@",url);
    }
    
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                                       timeoutInterval:settimeout];
#if TARGET_OS_IPHONE
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
#endif
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    urlsession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
	task = [urlsession dataTaskWithRequest:request];
	[task resume];
	return YES;
}

- (void)cancelConnection{
#if TARGET_OS_IPHONE
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
#endif
    //[self.theConnection cancel];
    //self.theConnection = nil;
    //self.receivedData = nil;
    [task cancel];
    task = nil;
    responseData = nil;
}
- (void)cancelRequest{
	//[self.theConnection cancel];
    //self.theConnection = nil;
    
    [task cancel];
    task = nil;
    responseData = nil;
}






/**
 * HTTPリクエストのデリゲートメソッド(データ受け取り初期処理)
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    // 保持していたレスポンスのデータを初期化
    //[self setResponseData:[[NSMutableData alloc] init]];
    responseData = [[NSMutableData alloc] init];
    
    // didReceivedData と didCompleteWithError が呼ばれるように、通常継続の定数をハンドラーに渡す
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * HTTPリクエストのデリゲートメソッド(受信の度に実行)
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 1つのパケットに収まらないデータ量の場合は複数回呼ばれるので、データを追加していく
    [responseData appendData:data];
}

/**
 * HTTPリクエストのデリゲートメソッド(完了処理)
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        // HTTPリクエスト失敗処理
        //[self failureHttpRequest:error];
        if (debugmode == YES) {
            NSLog(@"Connection failed! Error - %@ %@",
                  [error localizedDescription],
                  [error userInfo][NSURLErrorFailingURLStringErrorKey]);
        }
        if([self.delegate respondsToSelector:@selector(api:requestFailedWithError:)]){
            [self.delegate api:self requestFailedWithError:error];
        }
        
    } else {
        // HTTPリクエスト成功処理
        NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData
                                                        options:kNilOptions
                                                          error:&error];
        if(json == nil){
            NSLog(@"Json data is nil");
            if([self.delegate respondsToSelector:@selector(api:requestFailedWithError:)]){
                [self.delegate api:self requestFailedWithError:error];
            }
            
        }else{
            if (debugmode == YES) {
                NSLog(@"json:%@",json);
            }
            if([self.delegate respondsToSelector:@selector(api:readyWithList:)]){
                [self.delegate api:self readyWithList:json];
            }
        }

    }
}





@end

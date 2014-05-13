//
//  BGMAPI.m
//  bangumi
//
//  Created by bi119aTe5hXk on 2014/04/17.
//  Copyright (c) 2014年 HT&L. All rights reserved.
//

#import "BGMAPI.h"
#define settimeout 50
@interface BGMAPI ()
@property (assign, nonatomic) NSObject <BGMAPIDelegate> *delegate;
@property (retain, nonatomic) NSURLConnection *theConnection;
@property (retain, nonatomic) NSMutableData *receivedData;
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
    
    userdefaults = [NSUserDefaults standardUserDefaults];
    authString = [userdefaults stringForKey:@"auth"];
    authURLencoded = [userdefaults stringForKey:@"auth_urlencoded"];
    self.delegate = delegate;
    return self;
}


//-(NSString *)mainURLWithPath:(NSString *)path{
//    return [NSString stringWithFormat:@"%@%@",APIBaseURL,path];
//}

-(void)userLoginWithUserName:(NSString *)username WithPassword:(NSString *)password{
    NSString *url = [NSString stringWithFormat:LoginURL,username,password];
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@",appName]];
    [self createGETConnectionWithURL:url];
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
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?source=%@&auth=%@&start=%ld&max_results=20",appName,authURLencoded,(long)count]];
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
        NSLog(@"URL: %@",url);
    }
    
    if(self.theConnection){
		return NO;
	}
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    
//    NSMutableString *post_string =[NSMutableString string];
//    NSString *k;
//    for (k in post_data) {
//        if ([[post_data objectForKey:k] isKindOfClass:[NSString class]]) {
//            [post_string appendFormat:@"%@=%@", k, [[post_data objectForKey:k] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        } else {
//            [post_string appendFormat:@"%@=%@", k, [post_data objectForKey:k]];
//        }
//    }
    
//    NSError *jsonError;
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:post_data options:NSJSONWritingPrettyPrinted error:&jsonError];
    NSMutableString *body = [NSMutableString string];
    for (NSString *key in post_data) {
        NSString *val = [post_data objectForKey:key];
        if ([body length])
            [body appendString:@"&"];
        [body appendFormat:@"%@=%@", [[key description] urlEncodedUTF8String
                                      ],
         [[val description] urlEncodedUTF8String]];
    }
    
    
    
    //NSData *postData = [post_string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    if (debugmode == YES) {
        NSLog(@"Post Data: %@",body);
    }
    
    request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                  timeoutInterval:settimeout];
    
    //[request setURL:url];
    [request setHTTPMethod:@"POST"];
    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBody:postData];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPShouldHandleCookies:YES];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
	self.theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (self.theConnection) {
		self.receivedData = [NSMutableData data];
	}else {
		return NO;
	}
	return YES;
}


- (BOOL)createGETConnectionWithURL:(NSString *)urlstr{
    NSURL *url = [NSURL URLWithString:urlstr];
    
    [self cancelConnection];
    if (debugmode == YES) {
        NSLog(@"URL: %@",url);
    }
    
	if(self.theConnection){
		return NO;
	}
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                                       timeoutInterval:settimeout];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	self.theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (self.theConnection) {
		self.receivedData = [NSMutableData data];
	}else {
		return NO;
	}
	return YES;
}







- (void)cancelConnection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	//if(self.theConnection && self.isBusy){
    [self.theConnection cancel];
    self.theConnection = nil;
    self.receivedData = nil;
	//}
}
- (void)cancelRequest{
	[self.theConnection cancel];
    self.theConnection = nil;
}

# pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (self.receivedData == nil) {
        self.receivedData = [NSMutableData data];
    }
    if (debugmode == YES) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"t:%@",str);
    }
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	self.theConnection = nil;
    self.receivedData = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (debugmode == YES) {
        NSLog(@"Connection failed! Error - %@ %@",
              [error localizedDescription],
              [error userInfo][NSURLErrorFailingURLStringErrorKey]);
    }
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误"
//                                                        message:@"服务器无法连接"
//                                                       delegate:nil
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"了解", nil];
//    alertView.tag = 0;
//    [alertView show];
    if([self.delegate respondsToSelector:@selector(api:requestFailedWithError:)]){
		[self.delegate api:self requestFailedWithError:error];
	}
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:self.receivedData
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
        
//        if ([[[json valueForKey:@"response"] valueForKey:@"information"] valueForKey:@"has_error"] == [NSNumber numberWithBool:NO]) {
//            if (debugmode == YES) {
//                NSLog(@"information ok %@",[[json valueForKey:@"response"]  valueForKey:@"information"]);
//            }
//            
            if([self.delegate respondsToSelector:@selector(api:readyWithList:)]){
                [self.delegate api:self readyWithList:json];
            }
//        }else{
//            NSLog(@"return error %@",[[json valueForKey:@"response"]  valueForKey:@"information"]);
//            if([self.delegate respondsToSelector:@selector(api:requestFailedWithError:)]){
//                [self.delegate api:self requestFailedWithError:error];
//            }
//            
//        }
    }
    
    self.theConnection = nil;
    self.receivedData = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


@end

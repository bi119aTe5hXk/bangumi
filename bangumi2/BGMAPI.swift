//
//  BGMAPI.swift
//  bangumi2
//
//  Created by bi119aTe5hXk on 2016/03/21.
//  Copyright © 2016年 HT&L. All rights reserved.
//

import Foundation
import UIKit
@objc protocol BGMAPIDelegate {
    optional func readyWithList( list: NSArray)
    optional func requestFailedWithError (error:NSError)
}


class BGMAPI: NSObject {
    var userdefaults:NSUserDefaults!
    var authString:NSString!
    var authURLencoded:NSString!
    
    weak var delegate:BGMAPIDelegate?
    
    
    
    func initWithdelegate(delegate:BGMAPIDelegate) -> (BGMAPI){
        userdefaults = NSUserDefaults.standardUserDefaults()
        
        if (userdefaults.stringForKey("auth")!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
            authString = userdefaults.stringForKey("auth")
            authURLencoded = userdefaults.stringForKey("auth_urlencoded")
        }else{
            authString = ""
            authURLencoded = ""
        }
        
        
        self.delegate = delegate
        return self
    }
    
    func userLogin(username:NSString, password:NSString)  {
        print(username)
        var url = NSString(format: PostLoginURL)
        url = url.stringByAppendingString(NSString(format: "?source=%@",appName) as String)
        let dic:Dictionary<String,String> = ["username":username as String,"password":password as String];
        
        self.createPOSTConnectionWithURL(url, post_data: dic)
    }
    
    
    
    
    
    
    
    
    func createPOSTConnectionWithURL(urlstr:NSString, post_data:NSDictionary) {
        let url = NSURL(string: urlstr as String)
        
        let body = NSMutableString()
        
        
        for (key,value) in post_data {
            
            if (body.length>0){
                body.appendString("&")
                body.appendFormat("%@=%@",
                                  key.description.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!,
                                  value.description.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
            }
        }
        NSLog("Post Data: %@",body);

        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, resp, err) in
            print(resp!.URL!)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            do{
                let json: NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options:[]) as! NSArray
                
                self.delegate?.readyWithList!(json)
               
            }catch{
                //self.delegate?.requestFailedWithError()
                
            }
            
            
            
            
        })
        task.resume()
        
    }
    
}

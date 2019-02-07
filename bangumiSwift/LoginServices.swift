//
//  LoginServices.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/06.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit
import OAuthSwift

protocol LoginServicesHandlerDelegate {
    func LoginCompleted(_ sender: LoginServices, _ data: Any)
    func LoginFailed(_ sender: LoginServices, _ data: Any)
}

class LoginServices: NSObject , BangumiServicesHandlerDelegate{
    static var handlerDelegate: LoginServicesHandlerDelegate?
    
    static var oauthswift: OAuth2Swift?
    static let bs = BangumiServices()
    static let userdefaults = UserDefaults.standard
    static var requestType = ""
    static let nowTime = Date().timeIntervalSince1970
    
    static func isLogin() -> Bool {
        if (
            ((self.userdefaults.object(forKey: "oauthtoken") as? String)!.lengthOfBytes(using: String.Encoding.utf8) > 0) &&
            ((self.userdefaults.object(forKey: "refreshtoken") as? String)!.lengthOfBytes(using: String.Encoding.utf8) > 0) &&
            ((self.userdefaults.object(forKey: "userid") as? String)!.lengthOfBytes(using: String.Encoding.utf8) > 0) &&
            (self.userdefaults.object(forKey: "expirestime") as! Double) > 0.00
        ){
            print(self.userdefaults.object(forKey: "oauthtoken") as Any)
            return true
        }
        return false
    }
    static func isNotExpire() -> Bool{
        if ((self.userdefaults.object(forKey: "expirestime") as! Double) > nowTime){
            return true
        }
        return false
    }
    

    static func tryLogin() {
        oauthswift = OAuth2Swift(
            consumerKey: AppID,
            consumerSecret: AppSecret,
            authorizeUrl: "https://bgm.tv/oauth/authorize",
            accessTokenUrl: "https://bgm.tv/oauth/access_token",
            responseType: "code"
        )
        let state = generateState(withLength: 20)
        var handle = oauthswift!.authorize(
            withCallbackURL: URL(string: "bangumiplus://oauth-callback/bgm")!,
            scope: "mayday", state: state,
            success: { credential, response, parameters in
                print(credential.oauthToken)
                //self.userdefaults.set(credential.oauthToken, forKey: "oauthtoken")
                bs.getUserID(withPre: ["grant_type":"authorization_code",
                                       "client_id":AppID,
                                       "client_secret":AppSecret,
                                       "code":credential.oauthToken,
                                       "redirect_uri":"bangumiplus://oauth-callback/bgm",
                                       "state":state])
                requestType = "getToken"
            },
            failure: { error in
                print(error.localizedDescription)
                self.handlerDelegate?.LoginFailed(LoginServices.self(), error.localizedDescription)
            }
        )
    }
    
    static func tryRefreshToken(){
        let rtoken = self.userdefaults.object(forKey: "refresh_token") as? String
        bs.getUserID(withPre: ["grant_type":"refresh_token",
                               "client_id":AppID,
                               "client_secret":AppSecret,
                               "refresh_token":rtoken!,
                               "redirect_uri":"bangumiplus://oauth-callback/bgm"])
        requestType = "refreshToken"
    }
    
    static func setLogout() {
        LoginServices.userdefaults.set("", forKey: "oauthtoken")
        LoginServices.userdefaults.set("", forKey: "refreshtoken")
        LoginServices.userdefaults.set("", forKey: "userid")
        LoginServices.userdefaults.set("", forKey: "expirestime")
    }
    
    func Completed(_ sender: BangumiServices, _ data: Any) {
        var dic = (data as? Dictionary<String, Any>)!
        if LoginServices.requestType == "getToken" {
            LoginServices.userdefaults.set(dic["access_token"], forKey: "oauthtoken")
            LoginServices.userdefaults.set(dic["refresh_token"], forKey: "refreshtoken")
            LoginServices.userdefaults.set(dic["user_id"], forKey: "userid")
            var expirestime = LoginServices.nowTime + (Double(dic["expires_in"] as! Int))
            LoginServices.userdefaults.set(expirestime, forKey: "expirestime")
            
        }
        if LoginServices.requestType == "refreshToken" {
            LoginServices.userdefaults.set(dic["access_token"], forKey: "oauthtoken")
            LoginServices.userdefaults.set(dic["refresh_token"], forKey: "refreshtoken")
            var expirestime = LoginServices.nowTime + (Double(dic["expires_in"] as! Int))
            LoginServices.userdefaults.set(expirestime, forKey: "expirestime")
            
        }
        LoginServices.handlerDelegate?.LoginCompleted(self, true)
        
    }
    
    func Failed(_ sender: BangumiServices, _ data: Any) {
        print(data)
        LoginServices.handlerDelegate?.LoginFailed(self, data)
    }
    
    static func generateState(withLength len: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = UInt32(letters.count)
        
        var randomString = ""
        for _ in 0..<len {
            let rand = arc4random_uniform(length)
            let idx = letters.index(letters.startIndex, offsetBy: Int(rand))
            let letter = letters[idx]
            randomString += String(letter)
        }
        return randomString
    }
}

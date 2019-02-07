//
//  LoginServices.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/06.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit
import OAuthSwift
class LoginServices: NSObject {
    static var oauthswift: OAuth2Swift?
    static let userdefaults = UserDefaults.standard
    
    static func isLogin() -> Bool {
        if (self.userdefaults.object(forKey: "oauthtoken") as? String)!.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            print(self.userdefaults.object(forKey: "oauthtoken") as Any)
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
                self.userdefaults.set(credential.oauthToken, forKey: "oauthtoken")
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
    
    static func setLogout() {
        self.userdefaults.set("", forKey: "oauthtoken")
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

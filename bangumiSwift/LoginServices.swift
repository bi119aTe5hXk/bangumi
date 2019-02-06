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
    static var oauthswift: OAuthSwift?
    static let userdefaults = UserDefaults.standard
    
    static func isLogin() -> Bool {
        if (self.userdefaults.object(forKey: "oauthtoken") as? String)!.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            return true
        }
        return false
    }
    
    static func notLoginMSG(){
        
    }

    static func tryLogin() {
        let oauthswift = OAuth2Swift(
            consumerKey: AppID,
            consumerSecret: AppSecret,
            authorizeUrl: "https://bgm.tv/oauth/authorize",
            responseType: "token"
        )
        let handle = oauthswift.authorize(
            withCallbackURL: URL(string: "obangumiplus://oauth-callback/")!,
            scope: "", state: "panpanpan",
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
}

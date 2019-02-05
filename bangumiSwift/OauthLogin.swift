//
//  OauthLogin.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit
import OAuthSwift
class OauthLogin: NSObject {
    var oauthswift: OAuthSwift?

    func tryLogin() {
        let oauthswift = OAuth2Swift(
            consumerKey: AppID,
            consumerSecret: AppSecret,
            authorizeUrl: "https://bgm.tv/oauth/authorize",
            responseType: "token"
        )
        let handle = oauthswift.authorize(
            withCallbackURL: URL(string: "obangumiplus://oauth-callback/")!,
            scope: "", state: "banbanban",
            success: { credential, response, parameters in
                print(credential.oauthToken)
                // Do your request
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }
}

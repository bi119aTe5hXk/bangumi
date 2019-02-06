//
//  BangumiServices.swift
//  bangumiSwift
//
//  Created by bi119aTe5hXk on 2019/02/03.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import Foundation
import OAuthSwift
protocol BangumiServicesHandlerDelegate {
    func Completed(_ sender: BangumiServices, _ data: Any)
    func Failed(_ sender: BangumiServices, _ data: Any)
}

class BangumiServices {

    
    var description: String = ""
    
    static let masterURL = "https://api.bgm.tv/"
    var oauthswift: OAuthSwift?

    var handlerDelegate: BangumiServicesHandlerDelegate?

    func tryLogin() {
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
                // Do your request
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }

    func calendar() {
        createConnectionWithURL(BangumiServices.masterURL + "calendar", "GET", nil)
    }



    func createConnectionWithURL(_ url: String, _ method: String, _ data: Dictionary<String, String>?) {
        var request: URLRequest? = nil
        print(url)
        switch method
        {
        case "GET":
            var components = URLComponents(string: url)

            if(data != nil)
            {
                for(k, v) in data!
                {
                    components?.queryItems?.append(URLQueryItem(name: k, value: v))
                }
            }

            request = URLRequest(url: (components?.url)!)
            request?.httpMethod = "GET"

            break
        case "POST":
            let jsonEncoder = JSONEncoder()

            let urlObject = URL(string: url)
            request = URLRequest(url: urlObject!)
            request?.httpMethod = "POST"

            do {
                try request?.httpBody = jsonEncoder.encode(data)
            }
            catch { }

            break
        default:
            return;
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request!, completionHandler: { (data, rep, err) in
            var v: Any

            if (data != nil)
                {
                do {
                    try v = JSONSerialization.jsonObject(with: data!, options: [])
                    print(v)
                    self.handlerDelegate?.Completed(self, v)
                }
                catch {
                    self.handlerDelegate?.Failed(self, error.localizedDescription)
                }
            }
            else {
                //v=err
                self.handlerDelegate?.Failed(self, err!.localizedDescription)
            }


        }).resume()


    }
}

//
//  BangumiServices.swift
//  bangumiSwift
//
//  Created by bi119aTe5hXk on 2019/02/03.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import Foundation
import Alamofire
var requestManager = Alamofire.Session.default
let masterURL = "https://api.bgm.tv/"

func getUserID(withPre: Dictionary<String, String>?, completion: @escaping (Any?) -> Void) {
    let urlstr = "https://bgm.tv/oauth/access_token"
    requestManager.request(urlstr, method: .post, parameters: withPre, encoding: JSONEncoding.default).responseJSON { (response) in
        completion(response)
    }
}



func getDailyList(completion: @escaping (Any?) -> Void) {
    let urlstr = masterURL + "calendar"
    requestManager.request(urlstr, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
        completion(response)
    }
}
func getBGMDetail(withID: String, completion: @escaping (Any?) -> Void) {
    let urlstr = masterURL + "subject/" + withID
    requestManager.request(urlstr, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
        completion(response)
    }
}



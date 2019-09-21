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

func getUserID(withPre: Dictionary<String, String>?, completion: @escaping (Bool, Any?) -> Void) {
    let urlstr = "https://bgm.tv/oauth/access_token"
    requestManager.request(urlstr, method: .post, parameters: withPre, encoding: JSONEncoding.default).responseJSON { (response) in
        //print(response.result)
        switch response.result {
        case .success(let value):
            print(value)
            if let JSON = value as? [String: Any] {
                //let data = JSON["data"] as Any
                //print(data)
                completion(true, JSON)
            }
            break
        case .failure(let error):
            // error handling
            //UserDefaults.standard.set(false, forKey: "loggedin")
            completion(false, error.localizedDescription)
            break
        }
    }
}



func getDailyList(completion: @escaping (Bool, Any?) -> Void) {
    let urlstr = masterURL + "calendar"
    requestManager.request(urlstr, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
        //print(response.result)
        switch response.result {
        case .success(let value):
            print(value)
            if let arr = value as? [Any] {
                
                //let data = JSON["data"] as Any
                //print(data)
                completion(true, arr)
            }
            break
        case .failure(let error):
            // error handling
            //UserDefaults.standard.set(false, forKey: "loggedin")
            completion(false, error.localizedDescription)
            break
        }
    }
}
func getBGMDetail(withID: String, completion: @escaping (Bool, Any?) -> Void) {
    let urlstr = masterURL + "subject/" + withID
    requestManager.request(urlstr, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
        //print(response.result)
        switch response.result {
        case .success(let value):
            print(value)
            if let JSON = value as? [String: Any] {
                //let data = JSON["data"] as Any
                //print(data)
                completion(true, JSON)
            }
            break
        case .failure(let error):
            // error handling
            //UserDefaults.standard.set(false, forKey: "loggedin")
            completion(false, error.localizedDescription)
            break
        }
    }
}



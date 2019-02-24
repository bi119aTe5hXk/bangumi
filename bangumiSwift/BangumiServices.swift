//
//  BangumiServices.swift
//  bangumiSwift
//
//  Created by bi119aTe5hXk on 2019/02/03.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import Foundation



class BangumiServices {
    static let masterURL = "https://api.bgm.tv/"


    
    func getUserID(withPre:Dictionary<String, String>?, completion: @escaping ([String: Any]?, Error?) -> Void) {
        createConnectionWithURL("https://bgm.tv/oauth/access_token", "POST", withPre, completion:{(responseObject, error) in
            completion(responseObject, error)
        })
    }



    func getDailyList(completion: @escaping ([String: Any]?, Error?) -> Void) {
        createConnectionWithURL(BangumiServices.masterURL + "calendar", "GET", nil, completion:{(responseObject, error) in
            completion(responseObject, error)
        })
    }
    func getBGMDetail(withID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        createConnectionWithURL(BangumiServices.masterURL + "subject/" + withID, "GET", ["responseGroup":"large"], completion:{(responseObject, error) in
            completion(responseObject, error)
        })
    }
    


    func createConnectionWithURL(_ url: String, _ method: String, _ data: Dictionary<String, String>?, completion: @escaping ([String: Any]?, Error?) -> Void) {
        var request: URLRequest? = nil
        print(url)
        switch method
        {
        case "GET":
            var components = URLComponents(string: url)!

            if(data != nil)
            {
                for(k, v) in data!
                {
                    components.queryItems?.append(URLQueryItem(name: k, value: v))
                }
            }
            
//            components.queryItems = data.map { (key, value) in
//                URLQueryItem(name: key, value: value)
//            }

            request = URLRequest(url: (components.url)!)
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
            guard let data = data,                            // is there data
                let response = rep as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                err == nil else {                           // was there no error, otherwise ...
                    completion(nil, err)
                    return
            }
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(responseObject, nil)
//            var v: Any
//
//            do {
//                try v = JSONSerialization.jsonObject(with: data, options: [])
//                print(v)
//                //self.handlerDelegate?.Completed(self, v)
//            }
//            catch {
//                //self.handlerDelegate?.Failed(self, error.localizedDescription)
//            }


        }).resume()


    }
}

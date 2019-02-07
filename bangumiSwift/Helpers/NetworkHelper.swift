//
//  NetworkHelper.swift
//  bangumiSwift
//
//  Created by Xlfdll on 2019/02/06.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import Foundation

public class WebRequest {
    public static func Get(_ url: String, _ data: [String: String] = [:],
                           _ completed: @escaping ([String: Any]?, Error?) -> Void)
    {
        var urlComponents: URLComponents = URLComponents(string: url)!

        let queryItems = data.map {
            return URLQueryItem(name: $0, value: $1)
        }

        urlComponents.queryItems = queryItems

        var urlRequest: URLRequest = URLRequest(url: urlComponents.url!)

        urlRequest.httpMethod = "GET"

        let session = URLSession(configuration: URLSessionConfiguration.default)

        session.dataTask(with: urlRequest, completionHandler: { (data, rep, err) in
            var v: Any

            if (data != nil)
                {
                do {
                    try v = JSONSerialization.jsonObject(with: data!, options: [])

                    print(v)

                    completed(v, nil)
                }
                catch {
                    delegate?.OnFailed(error.localizedDescription)
                }
            }
            else {
                delegate?.OnFailed(err!.localizedDescription)
            }


        }).resume()
    }

    public static func Post(_ url: String, _ data: [String: String] = [:], _ delegate: ServiceHandlerDelegate? = nil)
}

//
//  API.swift
//  ListGithub
//
//  Created by Fernanda de Lima on 25/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import Foundation

enum Endpoint {
    case repository(String,String, Int)
    func pathEndpoint() -> String {
        switch self {
        case .repository(let language, let sort, let page):return "language:\(language)&sort=\(sort)&page=\(page)"
        }
    }
}

class API {
    static var page = 1
    static let baseUrl = "https://api.github.com/search/repositories?q="
    static func get <T: Any>
        (_ type: T.Type,
         endpoint: Endpoint,
         success:@escaping (_ item: T) -> Void,
         fail:@escaping (_ error: Error) -> Void) where T: Decodable {
        let url = "\(baseUrl)\(endpoint.pathEndpoint())"
        print("===>url: \(url)")
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //create session to connection
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                //verify response
                if let httpResponse = response as? HTTPURLResponse {
                    print("===>code response: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 200 { //it's ok
                        //verify if have response data
                        if let data = data {
                            let jsonDecoder = JSONDecoder()
                            let jsonArray = try jsonDecoder.decode(type.self, from: data)
                            success(jsonArray)
                        }
                    }
                }
            } catch {
                fail(error)
            }
        })
        task.resume()
    }
}

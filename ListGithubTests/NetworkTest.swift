//
//  NetworkTest.swift
//  ListGithubTests
//
//  Created by Fernanda de Lima on 28/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import Quick
import Nimble
import Mockingjay

@testable import ListGithub


class NetworkTest: QuickSpec{

    override func spec() {
        let object: [String:Any] = [
            "name": "Repo",
            "stargazers_count": 29,
            "owner":[
                "login": "user",
                "avatar_url":""
            ],
        ]
        
        describe("NetworkRequest") {
            var networkService: API!
            
            beforeEach {
                networkService = API()
            }
            
            context("get") {
                it("should return a json of type object when server response is a json object") {
                    self.stub(everything, json(object))
                    var jsonResponse: Repository? = nil
                    
                    API.get(Repository.self, endpoint: .repository("swift", "stars", API.page), success: { (repo) in
                            jsonResponse = repo
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    expect(jsonResponse).toEventuallyNot(beNil())
                }
                it("should return a error when server response is not a json") {
  
                    var errorResponse: Bool = false
                    
                    API.get(Repository.self, endpoint: .repository("", "stars", API.page), success: { (repo) in
                    }) { (error) in
                        errorResponse = true
                    }
                    expect(errorResponse).toEventuallyNot(beTrue())
                    
                }
            }
        }
    }
}

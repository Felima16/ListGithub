//
//  ModelTest.swift
//  ListGithubTests
//
//  Created by Fernanda de Lima on 28/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import Nimble
import Quick

@testable import ListGithub

extension Item {
    static func validJson() -> Item {
        return Item(name: "Repo 1", stargazers_count: 302, owner: Owner(login: "user 1", avatar_url: ""))
    }
}

class ModelTest: QuickSpec{

    override func spec() {
        describe("Item") {
            var item: Item!
            var validJson: Item!
            beforeEach {
                validJson = Item.validJson()
            }
            
            it("should parse all properties") {
                item = validJson
                
                expect(item.name) == "Repo 1"
                expect(item.stargazers_count) == 302
                expect(item.owner.login) == "user 1"
                expect(item.owner.avatar_url) == ""
            }
        
        }
    }

    
}

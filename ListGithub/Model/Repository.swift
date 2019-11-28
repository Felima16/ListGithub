//
//  Repository.swift
//  ListGithub
//
//  Created by Fernanda de Lima on 25/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import Foundation

struct Repository: Codable{
    var items: [Item]
}

struct Item: Codable{
    var name:   String
    var stargazers_count:  Int
    var owner:  Owner
}

struct Owner: Codable{
    var login: String
    var avatar_url: String
}

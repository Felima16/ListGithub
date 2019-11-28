//
//  ListGithubTests.swift
//  ListGithubTests
//
//  Created by Fernanda de Lima on 22/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import ListGithub

class ListGithubTests: QuickSpec {
    
    override func spec() {
        var list: ListGitViewController!
        var tableView: UITableView!
        
        describe("ListGitViewController") {
            beforeEach {
                let data = [Item(name: "repo 1", stargazers_count: 304, owner: Owner(login: "User 1", avatar_url: "https://images.app.goo.gl/qWAqLJBRRqZQzJaZ6")),
                            Item(name: "repo 2", stargazers_count: 300, owner: Owner(login: "User 2", avatar_url: "https://images.app.goo.gl/qWAqLJBRRqZQzJaZ6"))]
                list = ListGitViewController()
                list.repositories = data
                
                tableView = UITableView()
                tableView.register(RepositoryCell.self,
                                   forCellReuseIdentifier: "cellID")
                tableView.dataSource = list
                tableView.delegate = list
                list.loadView()
                tableView.reloadData()
            }
            it("should return the right number of rows") {
                expect(list.tableView(tableView, numberOfRowsInSection: 0)) == 2
            }
            it("should return repo 1 view for indexPath.row = 0") {
                let indexPath = IndexPath(row: 0, section: 0)
                
                let cell = list.tableView(tableView, cellForRowAt: indexPath) as! RepositoryCell
                cell.repository = list.repositories[indexPath.row]
                expect(cell) == snapshot()
            }
            
            it("should retur repo 2 view for indexPath.row = 1") {
                let indexPath = IndexPath(row: 1, section: 0)
                
                let cell = list.tableView(tableView, cellForRowAt: indexPath) as! RepositoryCell
                cell.repository = list.repositories[indexPath.row]
                
                expect(cell) == snapshot()
            }
        }
    }
}

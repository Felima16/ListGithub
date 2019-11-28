//
//  ViewController.swift
//  ListGithub
//
//  Created by Fernanda de Lima on 22/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import UIKit

class ListGitViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    let cellid = "cellID"
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var repositories: [Item] = [Item]()
    
    override func loadView() {
        super.loadView()
        safeArea = view.layoutMarginsGuide
        setupTableView()
        getRepositories()
    }
    
    func setupTableView() {
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: cellid)
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshRepository(_:)), for: .valueChanged)
    }
    
    func getRepositories(){
        API.get(Repository.self, endpoint: .repository("swift", "stars", API.page), success: { (repo) in
            API.page += 1
            DispatchQueue.main.async() {
                self.refreshControl.isRefreshing ? self.repositories = repo.items : self.repositories.append(contentsOf: repo.items)
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing{
                    self.refreshControl.endRefreshing()
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    @objc private func refreshRepository(_ sender: Any) {
        API.page = 1
        getRepositories()
    }

}

extension ListGitViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! RepositoryCell
        cell.repository = repositories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row ==  self.repositories.count - 1{
            self.getRepositories()
        }
    }
}


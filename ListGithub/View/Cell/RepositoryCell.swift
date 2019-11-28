//
//  RepositoryCell.swift
//  ListGithub
//
//  Created by Fernanda de Lima on 25/11/19.
//  Copyright © 2019 Felima. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    var repository: Item? {
        didSet{
            repositoryNameLabel.text = repository?.name
            authorNameLabel.text = repository?.owner.login
            scoreLabel.text = "\(repository?.stargazers_count ?? 0)"
            let url = URL(string: (repository?.owner.avatar_url)!)!
            downloadImage(from: url)
        }
    }
    
    var avatarImg: UIImage? {
        didSet{
            avatarImage.image = avatarImg
        }
    }
    
    private let repositoryNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let authorNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightText
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let scoreLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let avatarImage : UIImageView = {
           let img = UIImageView()
           img.contentMode = .scaleAspectFit
           img.clipsToBounds = true
           return img
    }()
    
    private let starIcon : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "star")
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        addSubview(repositoryNameLabel)
        addSubview(authorNameLabel)
        addSubview(starIcon)
        addSubview(scoreLabel)
        addSubview(avatarImage)
        
        repositoryNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: avatarImage.leftAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        avatarImage.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 50, height: 50, enableInsets: false)
        authorNameLabel.anchor(top: repositoryNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: avatarImage.leftAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        starIcon.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: scoreLabel.leftAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 10, paddingRight: 5, width: 20, height: 20, enableInsets: false)
        scoreLabel.anchor(top: authorNameLabel.bottomAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.avatarImg = UIImage(data: data)
            }
        }
    }
}

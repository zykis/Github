//
//  UserCell.swift
//  Github
//
//  Created by Артём Зайцев on 18.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var avatarImageView: UIImageView?
    @IBOutlet weak var followersLabel: UILabel?
    @IBOutlet weak var starsLabel: UILabel?
    
    func update(with user: User) {
        self.usernameLabel?.text = user.username
        self.nameLabel?.text = user.name ?? ""
        self.locationLabel?.text = user.location ?? ""
        self.followersLabel?.text = "Followers: \(user.followers)"
        self.starsLabel?.text = "Stars: \(user.stargazersCount)"
        if self.avatarImageView?.image == nil {
            self.avatarImageView?.downloadAndSetupImage(with: URL(string: user.avatarUrl), completion: nil)
        }
    }
}

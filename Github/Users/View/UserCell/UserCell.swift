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
    var profileUrlString: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(browse))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func browse() {
        guard let profileUrlString = self.profileUrlString, let profileUrl = URL(string: profileUrlString) else { return }
        UIApplication.shared.open(profileUrl, options: [:], completionHandler: nil)
    }
    
    func update(with user: User) {
        self.profileUrlString = user.url
        
        self.usernameLabel?.text = user.username
        self.nameLabel?.text = user.name ?? ""
        self.locationLabel?.text = user.location ?? ""
        self.followersLabel?.text = "Followers: \(user.followers)"
        self.starsLabel?.text = "Stars: \(user.stargazersCount)"
        if self.avatarImageView?.image == nil {
            self.avatarImageView?.downloadAndSetupImage(with: URL(string: "\(user.avatarUrl)&size=\(avatarImageView?.bounds.size.width ?? 88)"), completion: nil)
        }
    }
}

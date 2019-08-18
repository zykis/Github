//
//  UserPresenter.swift
//  Github
//
//  Created by Артём Зайцев on 16.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import Foundation


protocol UserViewProtocol: class {
    func reloadData()
}


protocol UserPresenterProtocol {
    init(view: UserViewProtocol)
    func handleViewDidLoad()
    func userCount() -> Int
    func user(at indexPath: IndexPath) -> User
}


class UserPresenter: NSObject, UserPresenterProtocol {
    weak var view: UserViewProtocol?
    var users: [User] = []
    
    required init(view: UserViewProtocol) {
        self.view = view
    }
    
    func handleViewDidLoad() {
        APIManager.shared.getUsernames(completion: { (usernames, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let usernames = usernames else { return }
            for username in usernames {
                
                APIManager.shared.getUser(login: username, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    guard let user = user else { return }
                    DispatchQueue.main.async {
                        self.users.append(user)
                        self.view?.reloadData()
                    }
                    
                    APIManager.shared.getStargazedCount(login: user.username, completion: { (stargezers, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        guard stargezers != nil else { return }
                        if let u = self.users.first(where: { $0.username == user.username }) {
                            DispatchQueue.main.async {
                                u.stargazersCount = stargezers!
                                self.view?.reloadData()
                            }
                        }
                    })
                })
            }
        })
    }
    
    func user(at indexPath: IndexPath) -> User {
        return self.users[indexPath.row]
    }
    
    func userCount() -> Int {
        return self.users.count
    }
}

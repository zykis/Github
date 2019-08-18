//
//  UserPresenter.swift
//  Github
//
//  Created by Артём Зайцев on 16.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import Foundation


protocol UserViewProtocol: class {
    func update()
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
        APIManager.shared.getUsers { (data, response, error) in
            guard let data = data else { return }
            do {
                let usersJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                for userJson in usersJson! {
                    if let username = userJson["login"] as? String {
                        APIManager.shared.getUser(login: username, completion: { (data, response, error) in
                            guard let data = data else { return }
                            
                            let decoder = JSONDecoder()
                            do {
                                let user = try decoder.decode(User.self, from: data)
                                DispatchQueue.main.async {
                                    print(user.username)
                                    self.users.append(user)
                                    self.view?.update()
                                }
                            } catch let decodeError as NSError {
                                print("\(decodeError.localizedDescription)")
                                print(String(data: data, encoding: .utf8) ?? "")
                            } catch {
                                print("json decode error")
                            }
                        })
                    }
                }
            } catch let decodeError as NSError {
                print("\(decodeError.localizedDescription)")
            } catch {
                print("json decode error")
            }
        }
    }
    
    func user(at indexPath: IndexPath) -> User {
        return self.users[indexPath.row]
    }
    
    func userCount() -> Int {
        return self.users.count
    }
}

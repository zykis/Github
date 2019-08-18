//
//  APIManager.swift
//  Github
//
//  Created by Артём Зайцев on 16.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    static let shared = APIManager()
    
    private override init() {
        super.init()
    }
    
    func getUsers(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func getUser(login: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(login)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}

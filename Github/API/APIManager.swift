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
    
    func getUsernames(completion: @escaping ([String]?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                var usernames: [String] = []
                let usersJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                if usersJson == nil {
                    completion(nil, NSError(domain: "com.zykis.Github", code: 3, userInfo: [NSLocalizedDescriptionKey: "API calls exceeds"]))
                    return
                }
                for userJson in usersJson! {
                    if let username = userJson["login"] as? String {
                        usernames.append(username)
                    }
                }
                completion(usernames, nil)
            } catch let error as NSError {
                completion(nil, error)
            } catch {
                completion(nil, NSError(domain: "com.zykis.Github", code: 1, userInfo: [NSLocalizedDescriptionKey: "Uknowned error"]))
            }
        }
        task.resume()
    }
    
    func getUser(login: String, completion: @escaping (User?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(login)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: data)
                completion(user, error)
            } catch let decodeError as NSError {
                completion(nil, decodeError)
            } catch {
                completion(nil, NSError(domain: "com.zykis.Github", code: 2, userInfo: [NSLocalizedDescriptionKey: "Uknowned error"]))
            }
            
        }
        task.resume()
    }
    
    func getStargazedCount(login: String, completion: @escaping (Int?, Error?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(login)/repos")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            var stargazersCount = 0
            do {
                
                let reposJson: [[String:Any]]? = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                if reposJson == nil {
                    completion(nil, NSError(domain: "com.zykis.Github", code: 3, userInfo: [NSLocalizedDescriptionKey: "No repos found for user: \(login)"]))
                    return
                }
                for repoJson in reposJson! {
                    if let stargazers = repoJson["stargazers_count"] as? Int {
                        stargazersCount += stargazers
                    }
                }
                completion(stargazersCount, nil)
            } catch let error as NSError {
                completion(nil, error)
            } catch {
                completion(nil, NSError(domain: "com.zykis.Github", code: 4, userInfo: [NSLocalizedDescriptionKey: "Uknowned error"]))
            }
            
        }
        task.resume()
    }
}

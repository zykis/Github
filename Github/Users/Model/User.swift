//
//  Model.swift
//  Github
//
//  Created by Артём Зайцев on 16.08.2019.
//  Copyright © 2019 Артём Зайцев. All rights reserved.
//

import Foundation

class User: Decodable {
    var username: String
    var avatarUrl: String
    var followers: Int
    var name: String?
    var location: String?
    var stargazersCount: Int = 0
    var url: String?
    
    // Have to manually override because location and name keys could be "null"
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.followers = try container.decode(Int.self, forKey: .followers)
        self.url = try container.decode(String.self, forKey: .url)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? nil
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? nil
    }
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
        
        case url
        case followers
        case name
        case location
    }
}

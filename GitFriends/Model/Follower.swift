//
//  Follower.swift
//  GitFriends
//
//  Created by Nadia Siddiqah on 7/4/22.
//

import Foundation

// If underlying types are hashable, don't need to write hash functions 
struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
    
    /*
     Example of hashing function:
     func hash(into hasher: inout Hasher) {
        hasher.combine(login)
     }
     */
}

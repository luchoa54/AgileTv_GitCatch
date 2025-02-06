//
//  User.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation

struct User: Decodable {
    let owner: UserModel
    let repositories: [RepositoryModel]
}

struct UserModel: Decodable {
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
}

//
//  Repository.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

struct RepositoryModel: Decodable {
    let name: String
    let languagesURL: String
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case languagesURL = "languages_url"
        case language
    }
}

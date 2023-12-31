//
//  Ads.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 22.12.2023.
//

import Foundation

//
//  Ad.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import Foundation

struct Ads: Codable {
    let id: String?  // Используйте "_id" вместо "id"
    let type: Int?
    let title: String?
    let description: String?
    let media: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case title
        case description
        case media
    }
    
    init(id: String = "", type: Int, title: String = "", description: String = "", media: String = "") {
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.media = media
    }
}

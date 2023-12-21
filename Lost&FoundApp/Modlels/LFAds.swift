//
//  RMProfile.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import Foundation

struct LFAds: Codable {
    let id: String
    let title: String
    let type: Int
    let Description: String
    let userId: String
    let category: String
    let media: URL?
}

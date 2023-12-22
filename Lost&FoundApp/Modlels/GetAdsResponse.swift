//
//  GetAdsResponse.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 22.12.2023.
//


import Foundation


struct GetAdsResponse: Codable {
    let total: Int?
    let ads: [Ads]?
    
    init(total: Int = 0, ads: [Ads] = []) {
        self.total = total
        self.ads = ads
    }
}


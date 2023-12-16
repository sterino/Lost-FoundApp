//
//  LFMainCollectionViewCellViewModel.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 17.12.2023.
//

import Foundation

final class LFMainCollectionViewCellViewModel{
    
    public let adName: String
    public let adDate: String
    private let adImageUrl: URL?
    init(
        adName: String,
        adDate: String,
        adImageUrl: URL?
    ) {
        self.adName = adName
        self.adDate = adDate
        self.adImageUrl = adImageUrl
    }
    
}

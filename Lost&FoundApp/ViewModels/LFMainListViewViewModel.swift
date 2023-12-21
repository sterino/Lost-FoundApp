//
//  MainListViewViewModel.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class LFMainListViewViewModel: NSObject {
    func fetchCharacters(){
        
    }
}

extension LFMainListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LFMainCollectionViewCell.cellIndentifier,
            for: indexPath) as? LFMainCollectionViewCell else {
                fatalError("Unsupported cell")
            }
        let viewModel = LFMainCollectionViewCellViewModel(adName: "Куртка",
                                                          adDate: "17.12.2023",
                                                          adImageUrl: nil)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
}

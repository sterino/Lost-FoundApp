//
//  MainListView.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class MainListView: UIView {
    
    let viewModel = MainListViewViewModel()
    
    var adsList = [Ads()]
    
    
    var totals = 0
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.cellIndentifier)
        return collectionView
    }()
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        viewModel.fetchCharacters { total, ads in
            if let total = total, let ads = ads {
                self.adsList = ads
                self.totals = total
                print(self.totals)
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    self.collectionView.reloadData()
                    }
                
               
            )} else {
                print("Failed to fetch data")
            }
        }
        
        setUpCollectionView()
        
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("Unsupported")
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    private func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            
            self.spinner.stopAnimating()
            
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.4){
                self.collectionView.alpha = 1
            }
            
        })
    }
}

extension MainListView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.cellIndentifier,
            for: indexPath) as? MainCollectionViewCell else {
                fatalError("Unsupported cell")
            }
        
        let viewModel = MainCollectionViewCellViewModel(adName: self.adsList[indexPath.row].title ?? "",
                                                        adDate: self.adsList[indexPath.row].id ?? "",
                                                        adImageUrl: URL(string: self.adsList[indexPath.row].media ?? ""))

        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(totals)
        return self.totals
        
        
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




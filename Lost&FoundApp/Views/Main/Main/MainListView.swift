//
//  MainListView.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

protocol MainListViewDelegate {
    func didSelectAdCell(model: MainCollectionViewCellViewModel)
}

final class MainListView: UIView {
    var delegate: MainListViewDelegate?
    let viewModel = MainListViewViewModel()
    private let refreshControl = UIRefreshControl()
    var adsList = [Ads]()
    var filteredList = [Ads]()
    var segmentType = 1
   
//    var findList = [Ads()]
//    var lostList = [Ads()]
        
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
        viewModel.fetchCharacters { _, ads in
            if let ads = ads {
                self.adsList = ads.reversed()
                self.configureList()
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    self.collectionView.reloadData()
                    }
                
               
            )} else {
                print("Failed to fetch data")
            }
        }
        
        setUpCollectionView()
        setUpRefreshControl()
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("Unsupported")
    }
    
    public func update() {
        updateData()
    }
    
    func updateData() {
           spinner.startAnimating()
           viewModel.fetchCharacters { total, ads in
               if let total = total, let ads = ads {
                   self.adsList = ads.reversed()
                   self.configureList()
                   DispatchQueue.main.async {
                       self.collectionView.reloadData()
                       self.spinner.stopAnimating()
                   }
               } else {
                   print("Failed to fetch data")
               }
           }
       }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
        
            
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
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
        collectionView.refreshControl = refreshControl
    }
    private func setUpRefreshControl() {
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        }
    @objc private func refreshData() {
            updateData()
            refreshControl.endRefreshing()
        }
}

extension MainListView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.cellIndentifier,
            for: indexPath) as? MainCollectionViewCell else {
                fatalError("Unsupported cell")
            }
        let viewModel = MainCollectionViewCellViewModel(adName: self.filteredList[indexPath.row].title ?? "",
                                                        adDate: self.filteredList[indexPath.row].description ?? "",
                                                        adImageUrl: URL(string: self.filteredList[indexPath.row].media ?? ""))

        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = MainCollectionViewCellViewModel(adName: self.filteredList[indexPath.row].title ?? "",
                                                        adDate: self.filteredList[indexPath.row].description ?? "",
                                                        adImageUrl: URL(string: self.filteredList[indexPath.row].media ?? ""))
        delegate?.didSelectAdCell(model: viewModel)
    }
    
    private func configureList() {
        filteredList = adsList.filter { $0.type == segmentType }
    }
}


extension MainListView: SegmentedControlDelegate {
    func segmentedControlValueChanged(index: Int) {
        segmentType = index + 1
        configureList()
        collectionView.reloadData()
    }
}

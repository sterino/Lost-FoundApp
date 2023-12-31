//
//  MainCollectionViewCell.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let cellIndentifier = "LFMainCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, dateLabel)
        setupUI()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            
        ])

    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
    }
    
    public func configure(with viewModel: MainCollectionViewCellViewModel){
        if let imageURL = viewModel.adImageUrl {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        // Setting the image in UIImageView
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            self.imageView.image = UIImage(named: "placeholder.png")
        }
        nameLabel.text = viewModel.adName
        dateLabel.text = viewModel.adDate
    }
    func setupUI() {

                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.3
                layer.shadowOffset = CGSize(width: 0, height: 4)
                layer.shadowRadius = 6
       }
}

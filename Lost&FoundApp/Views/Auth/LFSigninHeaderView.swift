//
//  LFSigninHeaderView.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 18.12.2023.
//

import UIKit

class LFSigninHeaderView: UIView {

    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo1"))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Ошибка"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Ошибка"
        return label
    }()
    
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        self.setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        self.addSubview(logoImage)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImage.widthAnchor.constraint(equalToConstant: 200),
            self.logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: -50),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 19),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
        ])
    }
}

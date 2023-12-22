//
//  SigninHeaderView.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 18.12.2023.
//

import UIKit

class SigninHeaderView: UIView {

    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo1"))
        imageView.contentMode = .scaleAspectFit

        return imageView
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
        self.subTitleLabel.text = subTitle
        
        self.setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        self.addSubview(logoImage)
        self.addSubview(subTitleLabel)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImage.widthAnchor.constraint(equalToConstant: 200),
            self.logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
         
            self.subTitleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: -50),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            
        ])
    }
}

//
//  CustomLabel.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 22.12.2023.
//

import UIKit

class CustomLabel: UILabel {

    init(text: String) {
            super.init(frame: .zero)
            self.font = UIFont.boldSystemFont(ofSize: 25.0)
            self.textAlignment = .center
            self.text = text
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




}

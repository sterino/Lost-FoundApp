//
//  Extensions.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach({
            addSubview($0)
        })
        
    }
}

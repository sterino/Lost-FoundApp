//
//  MainFilterView.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 22.12.2023.
//

import UIKit

protocol SegmentedControlDelegate {
    func segmentedControlValueChanged(index: Int)
}

class MainFilterView: UIView {
    var delegate: SegmentedControlDelegate?
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo1"))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    var segmentedControl = UISegmentedControl(items: ["Потерянные", "Найденные"])
    
    override init(frame: CGRect){
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        backgroundColor = .systemBlue
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImage)
        addSubview(segmentedControl)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -80),
            self.logoImage.widthAnchor.constraint(equalToConstant: 200),
            self.logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            segmentedControl.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: -80),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            segmentedControl.heightAnchor.constraint(equalToConstant: 55),
            self.segmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            ])
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentedControlValueChanged(index: sender.selectedSegmentIndex)
    }

}

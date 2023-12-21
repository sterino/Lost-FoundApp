//
//  LFCreateAdViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class LFCreateAdViewController: UIViewController {
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    private let titleField: UITextField = {
        let titleField = UITextField()
        
        titleField.backgroundColor = .secondarySystemBackground
        titleField.layer.cornerRadius = 10
        titleField.layer.borderColor = UIColor.secondarySystemFill.cgColor
        titleField.layer.borderWidth = 2
        titleField.autocorrectionType = .yes
        titleField.autocapitalizationType = .words
        titleField.placeholder = "Айфон 14 про..."
        titleField.leftViewMode = .always
        titleField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
     
        return titleField
    }()
    
    private let textView: UITextView = {
        let textView =  UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 28)
        return textView
    }()
    
    private var selectedHeaderImage: UIImage?
    
    private let createAd = LFCustomButton(title: "Создать", hasBackground: true, fontSize: .big)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        
        
        title = "Создать"
        viewSetUp()
        self.createAd.addTarget(self, action: #selector(didTapCreateAd), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func didTapHeader() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func viewSetUp() {
        view.addSubview(headerImageView)
        view.addSubview(textView)
        view.addSubview(titleField)
        view.addSubview(createAd)
        
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        createAd.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.headerImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 50),
            self.headerImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            self.headerImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.headerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.titleField.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 60),
            self.titleField.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            self.titleField.heightAnchor.constraint(equalToConstant: 55),
            self.titleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            
            self.createAd.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 44 ),
            self.createAd.centerXAnchor.constraint(equalTo: titleField.centerXAnchor),
            self.createAd.heightAnchor.constraint(equalToConstant: 55),
            self.createAd.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
        ])
    }
    
    @objc private func didTapCreateAd() {
        guard let title = titleField.text,
              let body = textView.text,
                !title.trimmingCharacters(in: .whitespaces).isEmpty,
                !body.trimmingCharacters(in: .whitespaces).isEmpty
                else{
                    return
                }
        
        LFDatabaseManager.shared.createAd(type: 0, title: title, description: "DSD", category: "ada")
            }
        
}

extension LFCreateAdViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        selectedHeaderImage = image
        headerImageView.image = image
    }
}

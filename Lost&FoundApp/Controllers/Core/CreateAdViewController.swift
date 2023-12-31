//
//  CreateAdViewController.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class CreateAdViewController: UIViewController {
    
    private let imageText = CustomLabel(text: "Загрузите фотографию")
    private let titleText = CustomLabel(text: "Заголовок")
    private let descriptionText = CustomLabel(text: "Описание")
    private var selectedType: Int = 1
    
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
    
    let pickerView = UIPickerView()
    let options = ["Потерял", "Нашел"]
    
    private let titleField: UITextField = {
        let titleField = UITextField()
        
        titleField.backgroundColor = .secondarySystemBackground
        titleField.layer.cornerRadius = 10
        titleField.layer.borderColor = UIColor.secondarySystemFill.cgColor
        titleField.layer.borderWidth = 2
        titleField.autocorrectionType = .yes
        titleField.autocapitalizationType = .none
        titleField.placeholder = "Айфон 14 про..."
        titleField.leftViewMode = .always
        titleField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        titleField.font = .systemFont(ofSize: 20)
     
        return titleField
    }()
    
    private let textView: UITextView = {
        let textView =  UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.secondarySystemFill.cgColor
        textView.backgroundColor = .secondarySystemBackground
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 15)
        return textView
    }()
    
    private var ad_idImage = String()
    private var selectedHeaderImage: UIImage?
    
    private let createAd = CustomButton(title: "Создать", hasBackground: true, fontSize: .big)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        
        
        title = "Создать"
        viewSetUp()
        self.createAd.addTarget(self, action: #selector(didTapCreateAd), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapHeader))
        headerImageView.addGestureRecognizer(tap)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
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
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(imageText)
        scrollView.addSubview(pickerView)
        scrollView.addSubview(titleText)
        scrollView.addSubview(descriptionText)
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(titleField)
        scrollView.addSubview(textView)
        scrollView.addSubview(createAd)
        
        imageText.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        titleField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        createAd.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            imageText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -40),
            imageText.widthAnchor.constraint(equalTo: view.widthAnchor),

            
            headerImageView.topAnchor.constraint(equalTo: imageText.bottomAnchor, constant: 12),
            headerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            headerImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            headerImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            headerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            pickerView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 0),
            pickerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            pickerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            pickerView.heightAnchor.constraint(equalToConstant: 100),
            
            titleText.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 0),
            titleText.leftAnchor.constraint(equalTo: imageText.leftAnchor, constant: -80),
            titleText.widthAnchor.constraint(equalTo: view.widthAnchor),

            titleField.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 12),
            titleField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            titleField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            titleField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            titleField.heightAnchor.constraint(equalToConstant: 55),

            descriptionText.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            descriptionText.leftAnchor.constraint(equalTo: imageText.leftAnchor, constant: -80),
            descriptionText.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            textView.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            textView.heightAnchor.constraint(equalToConstant: 200),

            createAd.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 44),
            createAd.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            createAd.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            createAd.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            createAd.heightAnchor.constraint(equalToConstant: 55),
            createAd.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])

        scrollView.contentSize = CGSize(width: view.frame.width, height: createAd.frame.maxY + 20)
    }

    
    @objc private func didTapCreateAd() {
        guard let title = titleField.text,
              let body = textView.text,
              !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !body.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            return
        }
        
        DatabaseManager.shared.createAd(type: selectedType, title: title, description: body, category: "asdada") { result in
            switch result {
            case .success(let responseString):
                self.ad_idImage = String(responseString)
                
                if self.selectedHeaderImage != nil {
                    StorageManager.shared.uploadImage(image: self.selectedHeaderImage, adId: self.ad_idImage)
                    if self.selectedHeaderImage != nil {
                        StorageManager.shared.uploadImage(image: self.selectedHeaderImage, adId: String(self.ad_idImage))
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    self.titleField.text = nil
                    self.textView.text = nil
                    self.headerImageView.image = UIImage(systemName: "photo")
                    self.showAlert()
                })
                
            case .error(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Обьявление создано", message: "Ожидайте обратную связь", preferredStyle: .alert)
        
        // Добавление действия "OK"
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Обработка нажатия на кнопку "OK"
            print("Нажата кнопка OK")
        }
        alertController.addAction(okAction)
        
        // Добавление дополнительных действий, если необходимо
        
        // Показываем UIAlertController
        present(alertController, animated: true, completion: nil)
    }
    
}

extension CreateAdViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension CreateAdViewController:  UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return options.count
       }

       // MARK: - UIPickerViewDelegate

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return options[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           // Действия при выборе определенной опции
           
           selectedType = row + 1
       }
    
}

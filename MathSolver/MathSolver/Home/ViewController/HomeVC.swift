//
//  HomeVC.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 6.12.2023.
//

import UIKit
import TOCropViewController
import NeonSDK
import SwiftUI

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .homeBackColor
        // Label
        let label = UILabel()
        label.text = "Math Solver"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Font.custom(size: view.bounds.width * 0.08, fontWeight: .Bold)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * 0.05)
            make.right.left.equalToSuperview().inset(view.bounds.width * 0.2)
        }
        // Settings Button
        let setButton = UIButton()
        setButton.setImage(UIImage(named: "settings"), for: .normal)
        setButton.addTarget(self, action: #selector(setButtonTapped), for: .touchUpInside)
        view.addSubview(setButton)
        setButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.height * 0.075)
            make.right.equalToSuperview().inset(6)
            make.height.equalTo(50)
        }
        // History Button
        let historyButton = UIButton()
        historyButton.setTitle("History", for: .normal)
        historyButton.layer.cornerRadius = 15
        historyButton.backgroundColor = UIColor(red: 0.506, green: 0.318, blue: 0.875, alpha: 1)
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(setButton.snp.bottom).offset(50)
            make.right.left.equalToSuperview().inset(150)
            make.height.equalTo(40)
        }
        // Start Label
        let startLabel = UILabel()
        startLabel.text = "Start here"
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 0
        startLabel.font = Font.custom(size: view.bounds.width * 0.08, fontWeight: .Bold)
        view.addSubview(startLabel)
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(view.bounds.height * 0.2)
            make.right.left.equalToSuperview().inset(view.bounds.width * 0.2)
        }
        // Description Label
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Take a picture of your math problem or upload it from your photos."
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = Font.custom(size: view.bounds.width * 0.04, fontWeight: .Regular) // Dinamik font boyutu
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(20)
            make.right.left.equalToSuperview().inset(20)
        }
        // Line View
        let lineView = UIImageView()
        lineView.image = UIImage(named: "line2")
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
            
        }
        // Upload Button
        let uploadButton = UIButton()
        uploadButton.setImage(UIImage(named: "uploadImage"), for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        view.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(39)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.bounds.width * 0.6 * 0.6)
            make.bottom.equalToSuperview().inset(view.bounds.height * 0.1)
        }
    }
    
    @objc func setButtonTapped() {
        let settingsVC = SettingsVC()
        present(destinationVC: settingsVC, slideDirection: .right)
    }
    
    @objc func uploadButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePictureAction = UIAlertAction(title: "Take a Picture", style: .default) { _ in
            self.openCamera()
        }
        let uploadFromPhotosAction = UIAlertAction(title: "Upload From Photos", style: .default) { _ in
            self.openPhotoLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(takePictureAction)
        alertController.addAction(uploadFromPhotosAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    @objc func historyButtonTapped(){
        let vc = HistoryVC()
        present(destinationVC: vc, slideDirection: .right)
    }
}

// MARK: - Extension - ImagePickers and Delegates
extension HomeVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate,TOCropViewControllerDelegate {
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Kamera kullanılamıyor")
        }
    }
    
    func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.presentCropViewController(with: selectedImage)
            }
        } else {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentCropViewController(with image: UIImage) {
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = self
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.resetAspectRatioEnabled = false
        present(cropViewController, animated: true, completion: nil)
    }
    
    func onCropComplete(with croppedImage: UIImage) {
        guard let imageData = croppedImage.jpegData(compressionQuality: 1.0)?.base64EncodedString() else {
            print("Görüntüyü Base64'e çevirme başarısız.")
            return
        }
        let imageBase64 = "data:image/jpeg;base64,\(imageData)"
        
        MathpixAPI.parseLatex(imageBase64: imageBase64) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let latexResult):
                    if latexResult.isEmpty {
                        self.showMathNotFoundError()
                    } else {
                        let resultVC = ResultViewController()
                        resultVC.resultText = latexResult
                        self.present(resultVC, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    self.showMathNotFoundError()
                }
            }
        }
    }
    
    func showMathNotFoundError() {
        let alert = UIAlertController(title: "Math Not Detected", message: "No mathematical expression was found in the image.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        onCropComplete(with: image)
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: TOCropViewController) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
#Preview(body: {
    HomeVC()
})

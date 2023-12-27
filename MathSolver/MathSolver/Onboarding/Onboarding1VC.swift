//
//  Onboarding1VC.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 6.12.2023.
//

import UIKit
import NeonSDK
import SwiftUI

class Onboarding1VC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        view.backgroundColor = .onboardingBackColor
        // Frame Image
        let frameImage = UIImageView()
        frameImage.image = UIImage(named: "Frame8")
        frameImage.layer.zPosition = 1
        view.addSubview(frameImage)
        frameImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.72)
            make.width.equalTo(view.snp.width).multipliedBy(1)
        }
        // Center Image
        let centerImage = UIImageView()
        centerImage.image = UIImage(named: "CenterImage")
        view.addSubview(centerImage)
        centerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-view.bounds.height * 0.06)
            make.width.height.equalTo(view.snp.width).multipliedBy(0.5)
        }
        // Label
        let label = UILabel()
        label.text = "Welcome to Math Solver"
        label.font = UIFont.systemFont(ofSize: view.bounds.width * 0.08, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(centerImage.snp.bottom).offset(171)
            make.left.right.equalToSuperview().inset(52)
        }
        // Button 1
        let button1 = CustomButton(title: "Continue", font: UIFont.systemFont(ofSize: 17, weight: .semibold))
        button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
    }

    @objc func buttonTapped(){
        let pageViewController = CustomPageViewController()
        present(destinationVC: pageViewController, slideDirection: .right)
        
    }
}
#Preview(body: {
    Onboarding1VC()
})







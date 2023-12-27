//
//  PageViewController.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 6.12.2023.
//

import UIKit
import NeonSDK


class CustomPageViewController : NeonOnboardingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        self.configureButton(
            title: "Continue",
            titleColor: .white,
            font: Font.custom(size: 17, fontWeight: .SemiBold),
            cornerRadious: 30,
            height: 60,
            horizontalPadding: 20,
            bottomPadding: 50,
            backgroundColor: UIColor(red: 0.51, green: 0.32, blue: 0.87, alpha: 1.00),
            borderColor: nil,
            borderWidth: nil
        )
        self.configureBackground(
            type: .topVectorImage(backgroundColor: UIColor(red: 0.96, green: 0.97, blue: 1.00, alpha: 1.00), offset: 50, horizontalPadding: 70)
        )
        self.configurePageControl(
            type: .V4,
            currentPageTintColor: .darkGray,
            tintColor: .lightGray,
            radius: 4,
            padding: 16)
        self.configureText(
            titleColor: .black,
            titleFont: Font.custom(size: 34, fontWeight: .Bold),
            subtitleColor: .black,
            subtitleFont: Font.custom(size: 17, fontWeight: .Regular))
        self.addPage(
            title: "Capture",
            subtitle: "Snap a photo of your math question",
            image: UIImage(named: "image3")!)
        self.addPage(
            title: "Solve",
            subtitle: "Our algorithm will solve it step-by-step",
            image: UIImage(named: "image4")!)
        self.addPage(
            title: "Learn",
            subtitle: "Understand the problem-solving process.",
            image: UIImage(named: "image5")!)
        Neon.onboardingCompleted()
    }
    override func onboardingCompleted() {
        let vc = PaywallVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}




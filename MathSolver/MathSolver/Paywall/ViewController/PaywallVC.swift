//
//  PaywallVC.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 6.12.2023.
//

import UIKit
import Adapty
import NeonSDK

class PaywallVC: UIViewController, AdaptyManagerDelegate {
    
    var paywallArr : [Paywall] = []
    var selectedIndex : Int?
    let monthlyButton = UIButton()
    let annualButton = UIButton()
    let bosImage = UIImageView()
    let bosImage2 = UIImageView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        packageFetched()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdaptyManager.delegate = self
        setupUI()
                AdaptyManager.selectedPaywall = AdaptyManager.getPaywall(placementID: "placement_2")
                      if let paywall = AdaptyManager.selectedPaywall{
                          Adapty.logShowPaywall(paywall)
                      }
    }
    func setupUI(){
        view.backgroundColor = .paywallViewBackColor
        
        let safeArea = view.safeAreaLayoutGuide
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let dissmissButton = UIButton()
        dissmissButton.setImage(UIImage(named: "dismissButton"), for: .normal)
        dissmissButton.addTarget(self, action: #selector(dissmissButtonClicked), for: .touchUpInside)
        
        view.addSubview(dissmissButton)
        dissmissButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(screenHeight * 0.03)
            make.right.equalTo(safeArea).inset(screenWidth * 0.05)
            make.height.width.equalTo(50)
        }
        //        paywallArr = []
        let paywallImage = UIImageView()
        view.addSubview(paywallImage)
        paywallImage.image = UIImage(named: "paywallImage")
        paywallImage.snp.makeConstraints { make in
            make.top.equalTo(dissmissButton.snp.bottom).offset(screenHeight * 0.01)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth * 0.4)
            make.height.equalTo(paywallImage.snp.width)
        }
        let paywallLabel = UILabel()
        paywallLabel.text = "Get Premium!"
        paywallLabel.numberOfLines = 0
        paywallLabel.font = Font.custom(size: 30, fontWeight: .SemiBold)
        paywallLabel.textColor = UIColor(red: 0.506, green: 0.318, blue: 0.875, alpha: 1)
        view.addSubview(paywallLabel)
        paywallLabel.snp.makeConstraints { make in
            make.top.equalTo(paywallImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        let featuresView = NeonPaywallFeaturesView()
        featuresView.featureTextColor = .black
        featuresView.featureIconBackgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        featuresView.featureIconTintColor = .black
        featuresView.addFeature(title: "Lorem Ipsum Dolor Sit", icon: UIImage(named: "icon3x")!)
        featuresView.addFeature(title: "Lorem Ipsum Dolor Sit", icon: UIImage(named: "icon3x")!)
        featuresView.addFeature(title: "Lorem Ipsum Dolor Sit", icon: UIImage(named: "icon3x")!)
        view.addSubview(featuresView)
        
        featuresView.snp.makeConstraints { make in
            make.top.equalTo(paywallLabel.snp.bottom).offset(30)
            make.left.right.equalTo(safeArea).inset(40)
            make.height.equalTo(80)
        }
        print(paywallArr)
        // İlk düğme (Monthly)
        monthlyButton.setTitle("Montly", for: .normal)
        monthlyButton.setTitleColor(.black, for: .normal)
        monthlyButton.contentHorizontalAlignment = .left
        monthlyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 0)
        monthlyButton.backgroundColor = .paywallBackColor
        monthlyButton.layer.cornerRadius = 25
        monthlyButton.addTarget(self, action: #selector(monthlyButtonTapped), for: .touchUpInside)
        view.addSubview(monthlyButton)
        monthlyButton.snp.makeConstraints { make in
            make.top.equalTo(featuresView.snp.bottom).offset(76)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth * 0.9)
            make.height.equalTo(82)
        }
        
        bosImage.image = UIImage(named: "bosNokta")
        view.addSubview(bosImage)
        bosImage.layer.zPosition = 1
        bosImage.snp.makeConstraints { make in
            make.top.equalTo(featuresView.snp.bottom).offset(screenHeight * 0.08)
            make.centerY.equalTo(monthlyButton)
            make.right.equalToSuperview().inset(50)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }

        // İkinci düğme (Annual)
        annualButton.setTitle("Annual", for: .normal)
        annualButton.contentHorizontalAlignment = .left
        annualButton.setTitleColor(.black, for: .normal)
        annualButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 0)
        annualButton.backgroundColor = .paywallBackColor
        annualButton.layer.cornerRadius = 25
        annualButton.addTarget(self, action: #selector(annualButtonTapped), for: .touchUpInside)
        view.addSubview(annualButton)
        annualButton.snp.makeConstraints { make in
            make.top.equalTo(monthlyButton.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth * 0.9)
            make.height.equalTo(82)
        }
        bosImage2.image = UIImage(named: "bosNokta")
        view.addSubview(bosImage2)
        bosImage2.layer.zPosition = 1
        bosImage2.snp.makeConstraints { make in
            make.top.equalTo(monthlyButton.snp.bottom).offset(23)
            make.centerY.equalTo(annualButton)
            make.right.equalToSuperview().inset(50)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        let button1 = CustomButton(title: "Start", font: Font.custom(size: 20, fontWeight: .SemiBold))
        button1.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.left.right.equalTo(safeArea).inset(20)
            make.height.equalTo(50)
            make.top.equalTo(annualButton.snp.bottom).offset(screenHeight * 0.05)
            make.bottom.equalToSuperview().inset(46)
        }
    }
    func updateDotImage(selectedButton: UIButton) {
        bosImage.image = UIImage(named: selectedButton == monthlyButton ? "doluNokta" : "bosNokta")
        bosImage2.image = UIImage(named: selectedButton == annualButton ? "doluNokta" : "bosNokta")
    }

    @objc func monthlyClicked() {
        updateDotImage(selectedButton: monthlyButton)
        
        AdaptyManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly")
        AdaptyManager.purchase(animation: .loadingBar) {
            if Neon.isUserPremium == true {
                let homeVC = HomeVC()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true)
            }
        } completionFailure: {
            // Failure :
        }
    }

    @objc func annualClicked() {
        updateDotImage(selectedButton: annualButton)
        
        AdaptyManager.selectPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual")
        AdaptyManager.purchase(animation: .loadingBar) {
            if Neon.isUserPremium == true {
                let homeVC = HomeVC()
                homeVC.modalPresentationStyle = .fullScreen
                self.present(homeVC, animated: true)
            }
        } completionFailure: {
            // Failure :
        }
    }


    func packageFetched() {
        paywallArr.removeAll(keepingCapacity: true)
        if let monthlyPackage = AdaptyManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Montly"){
            let price = monthlyPackage.localizedPrice
            let monthlyPrice = Paywall(name: "Monthly", fee: price ?? "")
            paywallArr.append(monthlyPrice)
            monthlyButton.setTitle("Monthly       \(price ?? "")", for: .normal)
            monthlyButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .SemiBold)
            
            
            
            if let annualPackage = AdaptyManager.getPackage(id: "com.neonapps.education.SwiftyStoreKitDemo.Annual"){
                let price = annualPackage.localizedPrice
                let annualPrice = Paywall(name: "Annual", fee: price ?? "")
                paywallArr.append(annualPrice)
                annualButton.setTitle("Annual       \(price ?? "")", for: .normal)
                annualButton.titleLabel?.font = Font.custom(size: 18, fontWeight: .SemiBold)
                
            }
        }
    }
    
    
    @objc func dissmissButtonClicked(){
        let homeVC = HomeVC()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
    @objc func buttonTapped() {
        if let selectedIndex = selectedIndex {
            if selectedIndex == 0 {
                monthlyClicked()
            } else if selectedIndex == 1 {
                annualClicked()
            } else {
                print("Geçersiz seçim")
            }
        } else {
            print("Paket seçilmedi")
        }
    }
    @objc func monthlyButtonTapped() {
        monthlyClicked()
    }

    @objc func annualButtonTapped() {
        annualClicked()
    }
    
    
    
    
    
}

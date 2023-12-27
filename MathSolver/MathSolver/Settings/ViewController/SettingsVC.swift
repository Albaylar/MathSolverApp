//
//  SettingsVC.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 7.12.2023.
//

import UIKit
import NeonSDK
import SwiftUI

class SettingsVC: UIViewController {
    
    private let settingsTableView: NeonTableView<SettingOption, SettingsTableViewCell> = {
        let options = [
            SettingOption(title: "Share app", icon: UIImage(named: "1")),
            SettingOption(title: "Rate us", icon: UIImage(named: "2")),
            SettingOption(title: "Contact us", icon: UIImage(named: "3")),
            SettingOption(title: "Terms of service", icon: UIImage(named: "4")),
            SettingOption(title: "Privacy policy", icon: UIImage(named: "5"))
        ]
        return NeonTableView<SettingOption, SettingsTableViewCell>(objects: options, heightForRows: 50,style: .plain)
    }()
    let label1 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        view.backgroundColor = .homeBackColor
        // Line View
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(UIScreen.main.bounds.height * 0.05)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        // Back Button
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.bounds.height * 0.01)
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width * 0.02)
            make.height.equalTo(UIScreen.main.bounds.height * 0.03)
            make.width.equalTo(UIScreen.main.bounds.width * 0.05)
        }
        // Solution Head Name
        let solutionNickLabel = UILabel()
        solutionNickLabel.text = "Settings"
        solutionNickLabel.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width * 0.04, weight: .semibold)
        solutionNickLabel.textAlignment = .center
        view.addSubview(solutionNickLabel)
        solutionNickLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(UIScreen.main.bounds.height * 0.01)
            make.centerX.equalToSuperview()
        }
        // Settings Table
        view.addSubview(settingsTableView)
        settingsTableView.layer.cornerRadius = 20
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(UIScreen.main.bounds.height * 0.03)
            make.left.right.equalToSuperview().inset(UIScreen.main.bounds.width * 0.07)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.51)
        }
        settingsTableView.didSelect = { [weak self] option, indexPath in
            self?.handleSelection(of: option)
        }
    }
    // Handle Title
    private func handleSelection(of option: SettingOption) {
        
        switch option.title {
        case "Share app":
            //TODO:
            break
        case "Rate us":
            //TODO:
            break
        case "Contact us":
            //TODO:
            break
        case "Terms of service":
            //TODO:
            break
        case "Privacy policy":
            //TODO:
            break
        default:
            break
        }
    }
    @objc func goBack(){
        self.dismiss(animated: true)
    }
}
#Preview(body: {
    SettingsVC()
})


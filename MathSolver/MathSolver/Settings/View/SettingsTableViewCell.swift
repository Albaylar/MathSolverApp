//
//  SettingsTableViewCell.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 7.12.2023.
//

import UIKit
import NeonSDK

class SettingsTableViewCell: NeonTableViewCell<SettingOption> {
    
    private let titleLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Icon Image Constraints
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(24) 
        }
        
        // Add titleLabel to contentView
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.lessThanOrEqualToSuperview().offset(-24)
        }
    }
    // Configure
    override func configure(with option: SettingOption) {
        super.configure(with: option)
        titleLabel.text = option.title
        iconImageView.image = option.icon
    }
}



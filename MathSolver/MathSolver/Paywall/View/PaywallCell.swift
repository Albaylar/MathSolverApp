//
//  PaywallCell.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 7.12.2023.
//

import UIKit
import NeonSDK

class PaywallCell: NeonCollectionViewCell<Paywall> {
    
    let selectedImage = UIImageView()
    let nameLabel = UILabel()
    var isSelectedButton: Bool = false
    let backView = UIView()
    let feeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    override func configure(with paywall: Paywall) {
        super.configure(with: paywall)
        nameLabel.text = paywall.name
        feeLabel.text = paywall.fee
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSubviews() {
        contentView.backgroundColor = .paywallViewBackColor
        contentView.addSubview(backView)
        
        //Back View
        backView.backgroundColor = .paywallBackColor
        backView.layer.cornerRadius = 25
        backView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(8)
            make.centerY.equalTo(contentView)
            make.height.equalTo(82)
        }
        //Name Label
        nameLabel.textColor = .black
        nameLabel.font = Font.custom(size: 15, fontWeight: .Medium)
        backView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(28)
        }
        // Fee Label
        feeLabel.textColor = .black
        feeLabel.font = Font.custom(size: 18, fontWeight: .SemiBold)
        backView.addSubview(feeLabel)
        feeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(22)
        }
        // Selected Image
        selectedImage.image = UIImage(named: "bosNokta")
        backView.addSubview(selectedImage)
        selectedImage.snp.makeConstraints { make in
            make.right.equalTo(backView).inset(10)
            make.width.height.equalTo(50)
            make.centerY.equalTo(backView)
        }
        
    }
}

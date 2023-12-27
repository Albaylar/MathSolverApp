//
//  Global.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 6.12.2023.
//

import UIKit
import NeonSDK

class CustomButton: UIButton {

    init(title: String, font: UIFont) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = font
        backgroundColor = UIColor(red: 0.51, green: 0.32, blue: 0.87, alpha: 1.00)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 28
        layer.masksToBounds = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


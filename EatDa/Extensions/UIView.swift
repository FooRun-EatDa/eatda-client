//
//  UIView.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/10.
//

import UIKit

extension UIView {
    func setViewShadow(backView: UIView) {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 1
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 3
    }
}

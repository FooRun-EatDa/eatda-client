//
//  UIColor.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색, 자주 쓰는 색 정의
    class var mainColor: UIColor { UIColor(hex: 0xffc107) }
    class var filterViewBorderColor: UIColor { UIColor(hex: 0xc7c7c7) }
    
    class var mainTextColor: UIColor { UIColor(hex: 0x191919) }
    class var subTextColor: UIColor { UIColor(hex: 0x6B7280) }
    class var highlightTextColor: UIColor { UIColor(hex: 0x16B96A) }
}

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
    
    // MARK: HomeViewController
    class var mainColor: UIColor { UIColor(hex: 0xFFC208) }
    class var applyButtonColor: UIColor { UIColor(hex: 0xFBB734) }
    class var seperatorColor: UIColor {UIColor(hex: 0xF8F8F8)}
    class var homeTitleColor: UIColor { UIColor(hex: 0xFF9F00) }
    class var lightGrayBorderColor: UIColor { UIColor(hex: 0xCACACA) }
    class var filterStrokeColor: UIColor {UIColor(hex: 0xFFC107)}
    class var grayTextColor: UIColor { UIColor(hex: 0x99999F)}
    class var filterClickBackgroundColor: UIColor {UIColor(hex: 0xFFEBAE)}
    class var filterBackgroundColor: UIColor {UIColor(hex: 0xFFEBAE)}
    class var uncheckTextColor: UIColor { UIColor(hex: 0xCECED0) }
    class var hashTagBackgroundColor: UIColor { UIColor(hex: 0xFDF2E6) }
    class var hashTagTextColor: UIColor { UIColor(hex: 0xFF8A00) }
    
    // MARK: SearchViewController
    class var searchBarBackgroundColor: UIColor { UIColor(hex: 0xF2F2F2) }
    
    // MARK: RestaurantDetailViewController
    class var mainTextColor: UIColor { UIColor(hex: 0x191919) }
    class var subTextColor: UIColor { UIColor(hex: 0x6B7280) }
    class var highlightTextColor: UIColor { UIColor(hex: 0x16B96A) }

}

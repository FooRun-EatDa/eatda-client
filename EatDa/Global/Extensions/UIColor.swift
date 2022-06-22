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

    // MARK: LoginViewController, TermsViewController
    class var divideViewColor: UIColor { UIColor(hex: 0xE5E5E5) }
    class var describeTextColor: UIColor { UIColor(hex: 0x717171) }
    class var buttonDisableColor: UIColor { UIColor(hex: 0xC8C8C8) }
    class var emailCheckColor: UIColor { UIColor(hex: 0x191991) }
    class var emailErrorColor: UIColor { UIColor(hex: 0xEB5757) }
    
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
    class var searchBarTextColor: UIColor { UIColor(hex: 0xBDBDBD) }
    
    // MARK: NoticeViewController
    class var dateGrayColor: UIColor { UIColor(hex: 0xC4C4C4) }
    class var noticeCellBackgroundColor: UIColor { UIColor(hex: 0xFFF8ED) }

    
    // MARK: RestaurantDetailViewController
    class var mainTextColor: UIColor { UIColor(hex: 0x191919) }
    class var subTextColor: UIColor { UIColor(hex: 0x6B7280) }
    class var timeTextColor: UIColor {UIColor(hex: 0xBBBBBB) }
    class var highlightTextColor: UIColor { UIColor(hex: 0x16B96A) }
    class var lightGreyColor: UIColor { UIColor(hex: 0xFAFAFA) }
    class var pointTextColor: UIColor { UIColor(hex: 0xFFAF38) }

    // MARK: 탭바 컬러
    class var gray1: UIColor { UIColor(hex: 0xBABABC) }

    // MARK: 마이페이지
    class var discribeTextColor: UIColor { UIColor(hex: 0x555555) }
    
}

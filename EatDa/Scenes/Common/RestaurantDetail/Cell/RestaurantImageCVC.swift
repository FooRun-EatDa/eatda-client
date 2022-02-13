//
//  RestaurantImageCVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/01/31.
//

import Foundation
import UIKit

class RestaurantImageCVC: UICollectionViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

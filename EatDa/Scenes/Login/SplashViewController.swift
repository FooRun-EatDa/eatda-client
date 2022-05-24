//
//  SplashViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/01.
//

import Foundation
import UIKit

final class SplashViewController: UIViewController {

    private lazy var logoImgae: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashImage")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(logoImgae)
        logoImgae.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

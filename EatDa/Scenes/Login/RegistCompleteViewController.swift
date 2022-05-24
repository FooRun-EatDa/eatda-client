//
//  RegistCompleteViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/10.
//

import Foundation
import UIKit

final class RegistCompleteViewController: UIViewController {

    var window: UIWindow?
    
    private lazy var logoImgae: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_success")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "지원님"
        titleLabel.textAlignment = .center
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()
    private lazy var welcomeLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "환영합니다"
        titleLabel.textAlignment = .center
        titleLabel.font = .myBoldSystemFont(ofSize: 22)
        return titleLabel
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(logoImgae)
        logoImgae.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
       
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImgae.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }

        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [self] in
            UserDefaults.standard.set(true, forKey: "loginComplete")
            NotificationCenter.default.post(name: Notification.Name("loginComplete"), object: nil)
            self.view.window?.rootViewController?.dismiss(animated: false)
        }
                
    }
}

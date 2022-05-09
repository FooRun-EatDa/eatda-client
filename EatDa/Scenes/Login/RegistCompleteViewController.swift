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
                          
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [self] in

            NotificationCenter.default.post(name: Notification.Name("doItSomeThing"), object: nil)
            self.view.window?.rootViewController?.dismiss(animated: false)
            
//            guard let pvc = self.presentingViewController else { return }
//            self.view.window!.rootViewController?.dismiss(animated: false) {
//                let nextVC = TabBarController()
//                let navController = UINavigationController(rootViewController: nextVC)
//                pvc.navigationController?.pushViewController(nextVC, animated: true)
//            }
        }
                
    }
}

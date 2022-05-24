//
//  SceneDelegate.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground

        var rootVC: UIViewController
        if UserDefaults.standard.bool(forKey: "loginComplete") {
            rootVC = TabBarController()
            
            window?.rootViewController = rootVC
            window?.makeKeyAndVisible()
        }else {
            rootVC = LoginViewController()
            let navVC = UINavigationController(rootViewController: rootVC)
            window?.rootViewController = navVC
            window?.makeKeyAndVisible()
        }
        
//        let navVC = UINavigationController(rootViewController: rootVC)
//        window?.rootViewController = navVC
//        window?.makeKeyAndVisible()
    }
}


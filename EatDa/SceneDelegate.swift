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
        window?.tintColor = .label
//        window?.rootViewController = TabBarController()
        //유저의 상태에 따라 다르게 보여줘야함. 지금은 그냥 푸시됨
        let rootVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navVC
        
        window?.makeKeyAndVisible()
        
    }


}


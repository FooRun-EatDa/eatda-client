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
                
        
        if UserDefaults.standard.bool(forKey: "loginComplete") { // 첫 시작이 아니라면
            if Const.headerToken != nil { // 토큰 값 확인하는 로직으로 변경 예정 -> 토큰 값 다르다면 로그인 과정
                print(Const.headerToken)
                print(Const.refreshToken)
                
                rootVC = TabBarController()
                window?.rootViewController = rootVC
                window?.makeKeyAndVisible()
            }
        } else {
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

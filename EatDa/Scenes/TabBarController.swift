//
//  TabBarController.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/26.
//

import UIKit

class TabBarController: UITabBarController {

    private lazy var communityViewController : UIViewController = {
        let viewController = UINavigationController(rootViewController: TalkViewController())
        viewController.tabBarItem = UITabBarItem(
            title: "맛집 톡",
            image: UIImage(imageLiteralResourceName: "talk"),
            tag: 2
        )

        return viewController
    }()
    
    private lazy var homeViewController : UIViewController = {
        let viewController = UINavigationController(rootViewController: HomeViewController())
        viewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "home"),
            selectedImage: UIImage(named: "home_fill")
        )
        
        return viewController
    }()
    
    private lazy var likeViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: LikeViewController())
        viewController.tabBarItem = UITabBarItem(
            title: "좋아요",
            image: UIImage(named: "heart"),
            tag: 1
        )
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        
        let eventViewController = UIViewController()
        eventViewController.tabBarItem = UITabBarItem(title: "이벤트", image: UIImage(named: "event"), tag: 3)
        let mypageViewController = UIViewController()
        mypageViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(named: "my"), tag: 4)
        
        viewControllers = [homeViewController, likeViewController, communityViewController, eventViewController, mypageViewController]
        
    }


}


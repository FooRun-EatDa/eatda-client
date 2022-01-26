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
        let tabBarItem = UITabBarItem(
            title: "맛집 톡",
            image: UIImage(imageLiteralResourceName: "talk"),
            tag: 2
        )
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let homeViewController = UIViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(imageLiteralResourceName: "home"), selectedImage: UIImage(imageLiteralResourceName: "home_fill"))
        let likeViewController = UIViewController()
        likeViewController.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(imageLiteralResourceName: "heart"), tag: 1)
        let eventViewController = UIViewController()
        eventViewController.tabBarItem = UITabBarItem(title: "이벤트", image: UIImage(imageLiteralResourceName: "event"), tag: 3)
        let mypageViewController = UIViewController()
        mypageViewController.tabBarItem = UITabBarItem(title: "마이", image: UIImage(imageLiteralResourceName: "my"), tag: 4)
        
        viewControllers = [homeViewController, likeViewController, communityViewController, eventViewController, mypageViewController]
        
    }


}


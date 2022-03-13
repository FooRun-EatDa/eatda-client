//
//  TalkViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/01/26.
//

import UIKit
import Tabman
import Pageboy

class TalkViewController: TabmanViewController {
   
    // MARK: - UIComponent
    private lazy var leftBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("경희대학교(국제)", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 0)
        return button
    }()

    
    private lazy var searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
    
   
    // MARK: - others
    var viewControllers: Array<UIViewController> = [CommunityViewController(), ReviewFeedViewController()]
    let bar = TMBar.ButtonBar()
    let inset: CGFloat = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setRightBarButtonItem()
        setLayout()
        settingTabBar(tmBar: bar)

        self.dataSource = self
    }
}


// MARK: - private
private extension TalkViewController {
    
    func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .label
    }
    
    func setRightBarButtonItem() {
        self.navigationItem.rightBarButtonItems = [searchBarButton]
    }
    
    func setLayout() {
        
        [leftBarButton].forEach { view.addSubview($0) }
        leftBarButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
        }
    }
    
    func settingTabBar(tmBar : TMBar.ButtonBar) {
        tmBar.layout.contentInset = UIEdgeInsets(top: 50.0, left: 0.0, bottom: 0.0, right: 0.0)
        tmBar.layout.transitionStyle = .snap
        tmBar.layout.alignment = .centerDistributed
        tmBar.layout.contentMode = .fit

        tmBar.buttons.customize { (button) in
            button.tintColor =  .gray1
            button.selectedTintColor = .mainTextColor
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        
        tmBar.indicator.weight = .custom(value: 2)
        tmBar.indicator.tintColor = .mainTextColor
        tmBar.indicator.overscrollBehavior = .compress
           
        tmBar.backgroundView.style = .flat(color: .white)
        
        addBar(tmBar, dataSource: self, at: .top)
    }
}


extension TalkViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "게시판")
        case 1:
            return TMBarItem(title: "리뷰피드")
        default:
            return TMBarItem(title: "게시판")
        }
    }
        
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}

//
//  CommunityViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/26.
//

import Tabman
import Pageboy

class TalkViewController: TabmanViewController {
    
    var viewControllers: Array<UIViewController> = [CommunityViewController() ,ReviewFeedViewController()]
    
    // MARK: - UIComponent
    let bar = TMBar.ButtonBar()
    private lazy var navBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("경희대학교(국제)", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 23.0)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        // 눌렀을때 학교 검색 controller 만들 예정
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        
        self.dataSource = self
        settingTabBar(tmBar: bar)
    }
}

extension TalkViewController: PageboyViewControllerDataSource, TMBarDataSource {
  
  func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
 
      // MARK: Tab
      switch index {
      case 0:
          return TMBarItem(title: "게시판")
      case 1:
          return TMBarItem(title: "리뷰피드")
      default:
          let title = "Page \(index)"
          return TMBarItem(title: title)
      }

  }
  
  func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
      //위에서 선언한 vc array의 count를 반환합니다.
      return viewControllers.count
  }

  func viewController(for pageboyViewController: PageboyViewController,
                      at index: PageboyViewController.PageIndex) -> UIViewController? {
      return viewControllers[index]
  }

  func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
      return nil
  }
}


private extension TalkViewController {
    // MARK: 네비게이션바
    func setupNavigationController(){
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        let navBarButton = UIBarButtonItem(customView: navBarButton)
        self.navigationItem.leftBarButtonItem = navBarButton
    }
    
    // MARK: 상단탭
    func settingTabBar (tmBar : TMBar.ButtonBar) {
        tmBar.layout.transitionStyle = .snap
        tmBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 20.0)
         
        // 간격
        tmBar.layout.interButtonSpacing = 35
             
        tmBar.backgroundView.style = .blur(style: .light)
         
        tmBar.buttons.customize { (button) in
            button.tintColor = .secondaryLabel
            button.selectedTintColor = .label
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .bold)
         }
         
        // 인디케이터
        tmBar.indicator.weight = .custom(value: 2)
        tmBar.indicator.tintColor = .label
        
        addBar(bar, dataSource: self, at: .top)
        
    }
}

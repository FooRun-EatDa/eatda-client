//
//  AroundDetailViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/26.
//

import UIKit
import RxSwift

final class AroundDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    // MARK: - UIComponent
    private lazy var  searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
        
    private lazy var  noticeBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "bell")
        return button
    }()
    
    let listView = RestaurantListView()
    
    override func loadView() {
        super.loadView()
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    func bind(_ viewModel: AroundDetailViewModel) {
        listView.bindAroundRestaurantData(viewModel.listViewModel)
        listView.rx.modelSelected(RestaurantListModel.self)
            .subscribe(onNext: { model in
                print(">> ", model.id)
            }).disposed(by: disposeBag)
    }

}


private extension AroundDetailViewController {
    func setNavigation() {
        self.navigationItem.title = "추천 맛집"
        self.navigationItem.rightBarButtonItems = [noticeBarButton, searchBarButton]
        let backButtonImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.myBoldSystemFont(ofSize: 16)]
    }

}

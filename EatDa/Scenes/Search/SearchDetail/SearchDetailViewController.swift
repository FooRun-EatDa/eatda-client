//
//  SearchDetailViewController.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import UIKit
import RxSwift

final class SearchDetailViewController: UIViewController {
    let disposeBag = DisposeBag()

    // MARK: - UIComponent
    let listView = RestaurantListView()
    
    override func loadView() {
        super.loadView()
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    func bind(_ viewModel: SearchDetailViewModel) {
        listView.bindSearchRestaurantData(viewModel)
        listView.rx.modelSelected(RestaurantListData.self)
            .subscribe(onNext: { model in
                print(">> ", model.id)
            }).disposed(by: disposeBag)
    }

    func setNavigationBar() {
        let backButtonImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
}

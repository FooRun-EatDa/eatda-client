//
//  SearchViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/05.
//

import UIKit
import SnapKit
import RxSwift

final class SearchViewController: UIViewController {
    let disposeBag = DisposeBag()

    // MARK: - UIComponent
    private lazy var  searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 12)
        searchBar.searchTextField.backgroundColor = UIColor.searchBarBackgroundColor
        searchBar.placeholder = "지역, 매장명, 메뉴 검색"
        return searchBar
    }()
    
    private lazy var searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
    
    let searchView = SearhView()
    
    override func loadView() {
        super.loadView()
        
        self.view = searchView
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationBar()
    }
    
    func bind(_ viewModel: SearchViewModel) {
        searchView.bind(viewModel)
        
        searchBarButton.rx.tap
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                let viewModel = SearchDetailViewModel(self.searchBar.text, 0)
                let viewController = SearchDetailViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.pushSearchDetailViewController
            .drive(onNext: { viewModel in
                let viewController = SearchDetailViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)

    }
}

private extension SearchViewController {
    func setNavigationBar() {
        let backButtonImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = searchBarButton
    }

}

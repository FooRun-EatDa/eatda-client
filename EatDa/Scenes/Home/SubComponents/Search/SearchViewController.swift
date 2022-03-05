//
//  SearchViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/05.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - UIComponent
    private lazy var  searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 12)
        searchBar.searchTextField.backgroundColor = UIColor.searchBarBackgroundColor
        searchBar.placeholder = "지역, 매장명, 메뉴 검색"
        return searchBar
    }()
    
    private lazy var  searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    func bind(_ viewModel: SearchViewModel) {
        
    }
}

private extension SearchViewController {
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = searchBarButton
        
    }
}

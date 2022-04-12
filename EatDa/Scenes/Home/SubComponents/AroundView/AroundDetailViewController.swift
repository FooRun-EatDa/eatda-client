//
//  AroundDetailViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/26.
//

import UIKit

final class AroundDetailViewController: UIViewController {

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
    
    private lazy var emptyHeaderView: UITableViewHeaderFooterView = {
        let headerView = UITableViewHeaderFooterView()
        return headerView
    }()

    private lazy var aroundTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .systemBackground
        tableview.rowHeight = 87.34
        tableview.separatorColor = .lightGray
        tableview.tableHeaderView = emptyHeaderView

        // api 연결할때 rx로 코드 변경할 예정
        tableview.delegate = self
        tableview.dataSource = self

        tableview.register(RestaurantTableViewCell.self, forCellReuseIdentifier: "RestaurantTableViewCell")

        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    

}

extension AroundDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as? RestaurantTableViewCell
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.setupLayout()

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97.34
    }

}

private extension AroundDetailViewController {
    func setLayout() {
        setNavigation()
        view.addSubview(aroundTableView)
        aroundTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().inset(30.0)
        }
    }
    
    func setNavigation() {
        self.navigationItem.title = "주변 맛집"
        self.navigationItem.rightBarButtonItems = [noticeBarButton, searchBarButton]
        let backButtonImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.myBoldSystemFont(ofSize: 16)]
    }

}

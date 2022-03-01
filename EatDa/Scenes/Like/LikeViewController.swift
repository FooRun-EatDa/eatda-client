//
//  LikeViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/28.
//

import UIKit

final class LikeViewController: UIViewController {
    
    // MARK: - UIComponent
    let headerView = LikeHeaderView(
        frame: CGRect(
            origin: .zero,
            // 해당 디바이스 너비만큼
            size: CGSize(width: UIScreen.main.bounds.width, height: 90.0)
        )
    )
    
    private lazy var  searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
    
    private lazy var likeTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .systemBackground
        tableview.rowHeight = 87.34
        tableview.separatorColor = .lightGray
        tableview.tableHeaderView = headerView
        
        // api 연결할때 rx로 코드 변경할 예정
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(LikeRestaurantCell.self, forCellReuseIdentifier: "LikeRestaurantCell")
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setLayout()
    }
    
    
}

extension LikeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeRestaurantCell", for: indexPath) as? LikeRestaurantCell
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.setupLayout()
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97.34
    }
    
}

private extension LikeViewController {
    func setNavigation() {
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    func setLayout() {
        view.addSubview(likeTableView)
        likeTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

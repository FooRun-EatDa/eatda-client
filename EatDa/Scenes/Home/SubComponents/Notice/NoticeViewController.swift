//
//  NoticeViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/23.
//

import UIKit

class NoticeViewController: UIViewController {
  
    private let headerView = NoticeHeaderView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 70.0)
        )
    )
    
    private lazy var noticeTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .systemBackground
        tableview.tableHeaderView = headerView
        tableview.separatorStyle = .none
        
        // api 연결할때 rx로 코드 변경할 예정
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeTableViewCell")
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
    }
    
    func bind(_ viewModel: NoticeViewModel) {
        
    }
}

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as? NoticeTableViewCell
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.76
    }
    
}

private extension NoticeViewController {
    func setNavigationBar() {
        let backButtonImage = UIImage(named: "back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setLayout() {
        setNavigationBar()
        
        view.addSubview(noticeTableView)
        noticeTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

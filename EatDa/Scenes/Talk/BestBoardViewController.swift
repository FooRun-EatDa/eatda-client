//
//  BestBoardViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/03/13.
//

import UIKit
import SnapKit

class BestBoardViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    private lazy var floatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floating_button"), for: .normal)
        button.layer.cornerRadius = 60
        button.clipsToBounds = true
        
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        button.layer.shadowOpacity = 1.0
        
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.register(BestBoardTVC.self, forCellReuseIdentifier: "BestBoardTVC")
        
        [tableView, floatButton].forEach { view.addSubview($0) }
    
        tableView.backgroundColor = .yellow
        tableView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
        floatButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(70)
            $0.height.width.equalTo(120)
        }
        
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }

    }
    
}


extension BestBoardViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BestBoardTVC", for: indexPath) as? BestBoardTVC else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{

        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))

        return view
    }
        
}

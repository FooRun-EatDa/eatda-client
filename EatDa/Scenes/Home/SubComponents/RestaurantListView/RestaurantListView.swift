//
//  RestaurantListView.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import UIKit
import RxSwift
import RxCocoa

class RestaurantListView: UITableView {
    let disposeBag = DisposeBag()

    private lazy var emptyHeaderView: UITableViewHeaderFooterView = {
        let headerView = UITableViewHeaderFooterView()
        return headerView
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.backgroundColor = .systemBackground
        self.register(RestaurantListCell.self, forCellReuseIdentifier: "RestaurantListCell")
        self.separatorInset = UIEdgeInsets.zero
        self.separatorColor = .lightGray
        self.rowHeight = 97.34
        self.tableHeaderView = emptyHeaderView

    }
    
    
    func bindRecommendRestaurantData(_ viewModel: RestaurantListViewModel) {
        viewModel.recommendRestaurantData
            .drive(self.rx.items) { tableview, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tableview.dequeueReusableCell(withIdentifier: "RestaurantListCell") as! RestaurantListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    func bindSearchRestaurantData(_ viewModel: SearchDetailViewModel) {
        viewModel.searchRestaurantData
            .drive(self.rx.items) { tableview, row, data in
                let index = IndexPath(row: row, section: 0)
                let cell = tableview.dequeueReusableCell(withIdentifier: "RestaurantListCell") as! RestaurantListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
}

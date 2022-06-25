//
//  LikeViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/02/28.
//

import UIKit
import RxSwift

final class LikeViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = LikeViewModel()

    // MARK: - UIComponent
    private lazy var  searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(imageLiteralResourceName: "search")
        return button
    }()
    
    
    private lazy var headerView = LikeHeaderView(
        frame: CGRect(
            origin: .zero,
            // 해당 디바이스 너비만큼
            size: CGSize(width: UIScreen.main.bounds.width, height: 90.0)
        )
    )
    
    private lazy var listView: UITableView = {
        let listView = UITableView()
        listView.register(RestaurantListCell.self, forCellReuseIdentifier: "RestaurantListCell")
        listView.separatorInset = UIEdgeInsets.zero
        listView.separatorColor = .lightGray
        listView.rowHeight = 97.34
        listView.tableHeaderView = headerView
        
        return listView
    }()
    
    override func loadView() {
        super.loadView()
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        bind(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
        listView.reloadData()
    }
    
    func bind(_ viewModel: LikeViewModel) {
        viewModel.likedRestaurantData.asDriver(onErrorJustReturn: [])
            .drive(listView.rx.items) { tableview, row, data in
                let cell = tableview.dequeueReusableCell(withIdentifier: "RestaurantListCell") as! RestaurantListCell
                print(data)
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
        
        listView.rx.modelSelected(RestaurantListModel.self)
            .subscribe(onNext: { model in
                print(">> ", model.id)
            }).disposed(by: disposeBag)
        
        viewModel.likedRestaurantData
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { data in
                self.headerView.setupData(data.count)
            }).disposed(by: disposeBag)
        
    }
    
}


private extension LikeViewController {
    func setNavigationBar() {
        navigationItem.rightBarButtonItem = searchBarButton
    }
    

}

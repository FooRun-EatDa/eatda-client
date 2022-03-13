//
//  CommunityViewController.swift
//  EatDa
//
//  Created by 김희진 on 2022/01/26.
//

import UIKit

class CommunityViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchingView = UIView()
    private var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.clipsToBounds = true
        bar.layer.cornerRadius = 4
        bar.layer.borderColor = UIColor.white.cgColor
        bar.layer.borderWidth = 0
        bar.placeholder = "지역, 매장명, 메뉴검색"
        return bar
    }()
        
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.separatorStyle = .none
        return view
    }()

    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()

        initUI()
    }
    
    func initUI(){
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.height.equalTo(1400)
            make.width.centerX.top.bottom.equalToSuperview()
        }
                
        [searchingView, tableView].forEach{ contentView.addSubview($0) }
    
        searchingView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        searchingView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
                
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchingView.snp.bottom)
            make.height.equalTo(900)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.layoutIfNeeded()
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        contentView.snp.remakeConstraints { make in
            make.height.equalTo(tableView.estimatedRowHeight * 9 + 750)
            make.width.centerX.top.bottom.equalToSuperview()
        }
    }
    
    func binding(){
        tableView.register(BoardMainTVC.self, forCellReuseIdentifier: "BoardMainTVC")
    }
}

extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoardMainTVC", for: indexPath) as? BoardMainTVC else {
            return UITableViewCell()
        }

        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        let view = UIView()
        view.backgroundColor = UIColor.seperatorColor
        return view
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{

        let view = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 60))

        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let vc = BestBoardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension CommunityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchWord = result.filter({ $0.word!.lowercased().prefix(searchText.count) == searchText.lowercased() })
        searching = true
//        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
//        tableView.reloadData()
    }
}


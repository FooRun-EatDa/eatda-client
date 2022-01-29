//
//  HomeViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UIComponent
    private lazy var leftBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("경희대학교(국제)", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20.0)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "arrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        // 눌렀을때 학교 검색 controller 만들 예정
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    
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
    
    private let categoryView = FilterView(title: "종류별", imageTitle: "category")
    private let districtView = FilterView(title: "지역별", imageTitle: "district")
    private let priceView = FilterView(title: "가격별", imageTitle: "price")
    private let hashtagView = FilterView(title: "해시태그", imageTitle: "hashtag")
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("조회하기", for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 15.0)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(imageLiteralResourceName: "logo"), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        // 눌렀을때
        //button.addTarget(self, action: #selector(), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setNavigation()
        setRightBarButtonItem()
        setLayout()
        
    }
    
}

// MARK: - private
private extension HomeViewController {
    // 상단 네비게이션 설정
    func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.tintColor = .label
    }

    func setRightBarButtonItem() {
        self.navigationItem.rightBarButtonItems = [noticeBarButton, searchBarButton]
    }
    
    func setLayout() {
        let titleBar = leftBarButton
        let applyButton = applyButton
        let filterStackView = UIStackView(arrangedSubviews: [categoryView, districtView, priceView, hashtagView])
        filterStackView.spacing = 8.0
        filterStackView.distribution = .fillEqually
        
        [
            titleBar,
            filterStackView,
            applyButton
        ]
        .forEach { view.addSubview($0) }
        
        let inset: CGFloat = 16.0

        titleBar.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
        }
        
        filterStackView.snp.makeConstraints {
            $0.top.equalTo(titleBar.snp.bottom).offset(inset)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.height.equalTo(86.0)
            $0.width.equalTo(72.0)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(filterStackView.snp.bottom).offset(inset)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.width.equalTo(315.0)
            $0.height.equalTo(52.0)
        }

    }
}


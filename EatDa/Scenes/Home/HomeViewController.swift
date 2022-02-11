//
//  HomeViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical  // 세로 스크롤이기 때문
        
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0

        let titleSectionView = TitleSectionView(frame: .zero)
        let filterSectionView = FilterSectionView(frame: .zero)
        let recommendSectionView = RecommendSectionView(frame: .zero)
        let aroundSectionView = AroundSectionView(frame: .zero)
    
        // 임의의 뷰 추가하여 스크롤 뷰 아래화면 끝까지 잘보이게
        let spacingView = UIView()
        spacingView.snp.makeConstraints {
            $0.height.equalTo(100.0)
        }
                
        [titleSectionView, filterSectionView, recommendSectionView, aroundSectionView, spacingView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        titleSectionView.snp.makeConstraints {
            $0.height.equalTo(30.0)
        }
        
        filterSectionView.snp.makeConstraints {
            $0.top.equalTo(titleSectionView.snp.bottom).offset(20.0)
            //$0.leading.trailing.equalToSuperview().inset(15.0)
        }
        
        recommendSectionView.snp.makeConstraints {
            $0.height.equalTo(350)
        }
        
        aroundSectionView.snp.makeConstraints {
            $0.height.equalTo(350)
        }
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setRightBarButtonItem()
        setupLayout()
    }
    
}

private extension HomeViewController {
    
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

    func setupLayout(){
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            // 세로 스크롤만 가능하게 - 가로만 고정
            $0.width.equalToSuperview()
        }
        

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

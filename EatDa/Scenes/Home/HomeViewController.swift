//
//  HomeViewController.swift
//  EatDa
//
//  Created by 김나희 on 2022/01/28.
//

import UIKit
import SnapKit
import RxSwift


class HomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    let homeViewModel = HomeViewModel()
    
    // MARK: - UIComponent
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let titleSectionView = TitleSectionView()
    let filterSectionView = FilterSectionView()
    let recommendSectionView = RecommendSectionView()
    let aroundSectionView = AroundSectionView()
    let mapSectionView = MapSectionView()
    
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
    
        // 임의의 뷰 추가하여 스크롤 뷰 아래화면 끝까지 잘보이게
        let spacingView = UIView()
        spacingView.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }
                
        [titleSectionView, filterSectionView, recommendSectionView, aroundSectionView, mapSectionView, spacingView]
            .forEach {
                stackView.addArrangedSubview($0)
            }

        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setupLayout()
        bind(homeViewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func bind(_ viewModel: HomeViewModel) {
        searchBarButton.rx.tap
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        noticeBarButton.rx.tap
            .bind(to: viewModel.noticeButtonTapped)
            .disposed(by: disposeBag)
        
        filterSectionView.applyButton.rx.tap
            .bind(to: viewModel.filterButtonTapped)
            .disposed(by: disposeBag)
        
        recommendSectionView.showAllButton.rx.tap
            .bind(to: viewModel.recommendDetailButtonTapped)
            .disposed(by: disposeBag)
        
        aroundSectionView.showAllButton.rx.tap
            .bind(to: viewModel.aroundDetailButtonTapped)
            .disposed(by: disposeBag)

        
        viewModel.pushSearchViewController
            .drive(onNext: { viewModel in
                let viewController = SearchViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.pushNoticeViewController
            .drive(onNext: { viewModel in
                let viewController = NoticeViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.filterButtonTapped
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                let viewController = FilterDetailViewController()
                //viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.recommendDetailButtonTapped
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                let viewController = RecommendDetailViewController()
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.aroundDetailButtonTapped
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {
                let viewController = AroundDetailViewController()
                //viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.tintColor = .label
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

//
//  HomeViewModel.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/05.
//

import RxSwift
import RxCocoa

struct HomeViewModel {
    let disposeBag = DisposeBag()
    
    let searchButtonTapped = PublishRelay<Void>()
    let pushSearchViewController: Driver<SearchViewModel>
    
    let noticeButtonTapped = PublishRelay<Void>()
    let pushNoticeViewController: Driver<NoticeViewModel>

    let filterButtonTapped = PublishRelay<Void>()
    
    let recommendDetailButtonTapped = PublishRelay<Void>()
    let pushRecommendDetailViewController: Driver<RecommendDetailViewModel>
    
    let aroundDetailButtonTapped = PublishRelay<Void>()
    let pushAroundDetailViewController: Driver<AroundDetailViewModel>

    let mapViewTapped = PublishSubject<Void>()
    
    init(model: RestaurantListNetwork = RestaurantListNetwork()) {
        let searchViewModel = SearchViewModel()
        let noticeViewModel = NoticeViewModel()
        let recommendDetailViewModel = RecommendDetailViewModel()
        let aroundDetailViewModel = AroundDetailViewModel()

        self.pushSearchViewController = searchButtonTapped
            .map { return searchViewModel }
            .asDriver(onErrorDriveWith: .empty())
        
        self.pushNoticeViewController = noticeButtonTapped
            .map { return noticeViewModel }
            .asDriver(onErrorDriveWith: .empty())
        
        self.pushRecommendDetailViewController = recommendDetailButtonTapped
            .map { return recommendDetailViewModel }
            .asDriver(onErrorDriveWith: .empty())
        
        self.pushAroundDetailViewController = aroundDetailButtonTapped
            .map { return aroundDetailViewModel }
            .asDriver(onErrorDriveWith: .empty())
            
    }
    
}

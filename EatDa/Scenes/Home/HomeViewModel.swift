//
//  HomeViewModel.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/05.
//

import RxSwift
import RxCocoa

struct HomeViewModel {
    let searchButtonTapped = PublishRelay<Void>()
    let pushSearchViewController: Driver<SearchViewModel>
    
    let noticeButtonTapped = PublishRelay<Void>()
    let pushNoticeViewController: Driver<NoticeViewModel>

    let filterButtonTapped = PublishRelay<Void>()
    let recommendDetailButtonTapped = PublishRelay<Void>()
    let aroundDetailButtonTapped = PublishRelay<Void>()
    let mapViewTapped = PublishSubject<Void>()

    init() {
        let searchViewModel = SearchViewModel()
        let noticeViewModel = NoticeViewModel()

        self.pushSearchViewController = searchButtonTapped
            .map { return searchViewModel }
            .asDriver(onErrorDriveWith: .empty())
        
        self.pushNoticeViewController = noticeButtonTapped
            .map { return noticeViewModel }
            .asDriver(onErrorDriveWith: .empty())
    }
}

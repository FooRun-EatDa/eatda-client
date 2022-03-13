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
    
    init() {
        let searchViewModel = SearchViewModel()

        self.pushSearchViewController = searchButtonTapped
            .map { return searchViewModel }
            .asDriver(onErrorDriveWith: .empty())
    }
}

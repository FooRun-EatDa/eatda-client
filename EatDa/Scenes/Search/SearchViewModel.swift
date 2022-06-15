//
//  SearchViewModel.swift
//  EatDa
//
//  Created by 김나희 on 2022/03/05.
//

import RxSwift
import RxCocoa

struct SearchViewModel {
    let disposeBag = DisposeBag()

    let searchLogData: Driver<[SearchLogModel]>
    let pushSearchDetailViewController: Driver<SearchDetailViewModel>
    
    let selectedLogData = PublishRelay<SearchLogModel>()

    init(_ model: SearchNetwork = SearchNetwork()) {
        let searchLogList = model.getSearchLogValue()

        self.searchLogData = searchLogList
            .asDriver(onErrorJustReturn: [])
        
        self.pushSearchDetailViewController = selectedLogData
            .map { return SearchDetailViewModel($0.searchText, 0) }
            .asDriver(onErrorDriveWith: .empty())

    }
}

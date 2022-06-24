//
//  SearchDetailViewModel.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchDetailViewModel {
    let searchRestaurantData: Driver<[RestaurantListModel]>
    let disposeBag = DisposeBag()

    init(_ keyword: String?, _ lastPage: Int, model: RestaurantListNetwork = RestaurantListNetwork()) {
        let searchRestauranListData = model.getSearchRestaurantValue(keyword ?? "", lastPage)
    
        self.searchRestaurantData = searchRestauranListData
            .asDriver(onErrorJustReturn: [])
    }
}

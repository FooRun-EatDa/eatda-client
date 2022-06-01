//
//  RestaurantListViewModel.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import RxSwift
import RxCocoa

struct RestaurantListViewModel {
    let cellData: Driver<[RestaurantListData]>

    init(model: RestaurantListNetwork = RestaurantListNetwork()) {
        let recommendDetailListViewData = model.getRecommendRestaurantValue()
        //let aroundDetailListViewData = model.getAroundRestaurantValue()

        self.cellData = recommendDetailListViewData
            .asDriver(onErrorJustReturn: [])
    }
}

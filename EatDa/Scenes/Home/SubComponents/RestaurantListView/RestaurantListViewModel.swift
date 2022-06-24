//
//  RestaurantListViewModel.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import RxSwift
import RxCocoa

struct RestaurantListViewModel {
    let recommendRestaurantData: Driver<[RestaurantListModel]>

    init(model: RestaurantListNetwork = RestaurantListNetwork()) {
        let recommendDetailListViewData = model.getRecommendRestaurantValue()
        //let aroundDetailListViewData = model.getAroundRestaurantValue()

        self.recommendRestaurantData = recommendDetailListViewData
            .asDriver(onErrorJustReturn: [])
    }
}

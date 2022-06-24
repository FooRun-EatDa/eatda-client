//
//  RestaurantDetailViewModel.swift
//  EatDa
//
//  Created by 김나희 on 5/24/22.
//

import RxSwift
import RxCocoa

struct RestaurantDetailViewModel {
    let aroundDetailButtonTapped = PublishRelay<Void>()

    let mapViewTapped = PublishSubject<Void>()
    let searchRestaurantData: Driver<RestaurantDetailModel>
    let disposeBag = DisposeBag()

    init(_ id: Int, model: RestaurantListNetwork = RestaurantListNetwork()) {
        let searchRestauranListData = model.getRestaurantDetailValue(id)
    
        self.searchRestaurantData = searchRestauranListData
            .asDriver(onErrorJustReturn: RestaurantDetailModel(id: 0, name: "", explanation: "", imgUrl: "", content: "", address: "", longitude: "", latitude: "", phoneNumber: "", operationTime: "", price: 0, district: "", categories: [], foods: [], reviews: [], liked: true) )
    }
}

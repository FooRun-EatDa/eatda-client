//
//  LikeViewModel.swift
//  EatDa
//
//  Created by 김나희 on 6/18/22.
//

import RxSwift
import RxCocoa

struct LikeViewModel {
    let disposeBag = DisposeBag()
    
    let likedRestaurantData = BehaviorRelay<[RestaurantListModel]>(value: [])

    init(model: RestaurantListNetwork = RestaurantListNetwork()) {
        let likedData = model.getLikedRestaurantValue()
        likedData.bind(to: likedRestaurantData)
    }
    
    func refreshData() {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_LIKED_RESTAURANT, method: .get, parameters: [:])
        apiCall.fetchWithRx().bind(to: likedRestaurantData)
    }
}

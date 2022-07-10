//
//  RestaurantListViewModel.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import RxSwift
import RxCocoa
import Alamofire

struct RestaurantListViewModel {
    let recommendRestaurantData: Driver<[RestaurantListModel]>
    let aroundRestaurantData: Driver<[RestaurantListModel]>
    
    let likeButtonTapped = PublishRelay<(Int, Bool)>()
    
    init(model: RestaurantListNetwork = RestaurantListNetwork()) {
        let recommendDetailListViewData = model.getRecommendRestaurantValue()
        // 임의로 정보 넣어둠
        let body: Parameters = [
            "latitude": 37.2429616,
            "longitude": 127.0800525
        ]
        let aroundDetailListViewData = model.getAroundRestaurantValue(body: body)

        self.recommendRestaurantData = recommendDetailListViewData
            .asDriver(onErrorJustReturn: [])
        self.aroundRestaurantData = aroundDetailListViewData
            .asDriver(onErrorJustReturn: [])
    }
    
    func tapLikeButton(_ id: Int, _ isLiked: Bool){
        let model = RestaurantListNetwork()
        if isLiked {
            model.postLikedRestaurant(id)
        } else {
            model.deleteLikedRestaurant(id)
        }
    }
}

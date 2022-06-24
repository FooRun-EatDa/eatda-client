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
    
    let likeButtonTapped = PublishRelay<(Int, Bool)>()
    
    init(model: RestaurantListNetwork = RestaurantListNetwork()) {
        let recommendDetailListViewData = model.getRecommendRestaurantValue()
        //let aroundDetailListViewData = model.getAroundRestaurantValue()

        self.recommendRestaurantData = recommendDetailListViewData
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

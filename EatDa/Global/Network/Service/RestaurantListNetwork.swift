//
//  RestaurantListNetwork.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import Foundation
import RxSwift
import Alamofire

struct RestaurantListNetwork {
    let disposeBag = DisposeBag()
    
    func getLikedRestaurantValue() -> Observable<[RestaurantListModel]> {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_LIKED_RESTAURANT, method: .get, parameters: [:])
        return apiCall.fetchWithRx()
    }
    
    func postLikedRestaurant(_ restaurantId: Int) {
        let apiCall = API<BasicModel>(url: APIConstants.GET_LIKED_RESTAURANT+"/"+String(restaurantId), method: .post, parameters: [:])
        apiCall.fetch(completion: { _ in return })
    }
    
    func deleteLikedRestaurant(_ restaurantId: Int) {
        let apiCall = API<BasicModel>(url: APIConstants.GET_LIKED_RESTAURANT+"/"+String(restaurantId), method: .delete, parameters: ["restaurantId": restaurantId])
        apiCall.fetch(completion: { _ in return })
    }
    
    func getRecommendRestaurantValue() -> Observable<[RestaurantListModel]> {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_RECOMMEND_RESTAURANT, method: .get, parameters: ["lastPage": 0])
        return apiCall.fetchWithRx()
    }
    
    func getSearchRestaurantValue(_ keyword: String, _ lastPage: Int) -> Observable<[RestaurantListModel]> {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_SEARCH_RESTAURANT, method: .get, parameters:  ["keyword": keyword, "lastPage": lastPage])
        return apiCall.fetchWithRx()
    }
    
    func getAroundRestaurantValue(body: Parameters) -> Observable<[RestaurantListModel]> {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_AROUND_RESTAURANT, method: .post, parameters: body)
        return apiCall.fetchWithRx()
    }

    func getRestaurantDetailValue(_ id: Int) -> Observable<RestaurantDetailModel> {
        let apiCall = API<RestaurantDetailModel>(url: APIConstants.GET_RESTAURANT_DETAIL + "\(id)", method: .get, parameters: [:])
        return apiCall.fetchWithRx()
    }
}

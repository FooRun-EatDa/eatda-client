//
//  RestaurantListNetwork.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import Foundation
import RxSwift

struct RestaurantListNetwork {
    func getRecommendRestaurantValue() -> Observable<[RestaurantListModel]> {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_RECOMMEND_RESTAURANT, method: .get, parameters: ["page": 1])
        return apiCall.fetchWithRx()
    }
    
    func getSearchRestaurantValue(_ keyword: String, _ lastPage: Int) -> Observable<[RestaurantListModel]> {
        let apiCall = API<[RestaurantListModel]>(url: APIConstants.GET_SEARCH_RESTAURANT, method: .get, parameters:  ["keyword": keyword, "lastPage": lastPage])
        return apiCall.fetchWithRx()
    }
    
//    func getAroundRestaurantValue() -> Observable<[RestaurantListData]> {
//        let apiCall = API<[RestaurantListData]>(url: APIConstants.GET_AROUND_RESTAURANT, method: .get, parameters: ["page": 1])
//        return apiCall.fetchWithRx()
//    }
    
}

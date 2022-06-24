//
//  SearchNetwork.swift
//  EatDa
//
//  Created by 김나희 on 6/10/22.
//

import RxSwift

struct SearchNetwork {
    func getSearchLogValue() -> Observable<[SearchLogModel]> {
        let apiCall = API<[SearchLogModel]>(url: APIConstants.GET_SEARCH_LOG, method: .get, parameters: [:])
        return apiCall.fetchWithRx()
    }
    
}

//
//  RestaurantDetailModel.swift
//  EatDa
//
//  Created by 김희진 on 2022/06/17.
//

import Foundation

struct RestaurantDetailModel: Decodable {
    let id: Int
    let name: String
    let explanation: String
    let imgUrl: String
    let content: String
    let address: String
    let longitude: String
    let latitude: String
    let phoneNumber: String
    let operationTime: String
    let price: Int
    let district: String
    let categories: [Int]
    let foods: [Int]
    let reviews: [Int]
    let liked: Bool
}

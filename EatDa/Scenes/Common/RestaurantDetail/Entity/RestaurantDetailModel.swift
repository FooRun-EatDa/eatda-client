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
    let foods: [MenuDetailModel]
    let reviews: [Int]
    let liked: Bool
}

struct MenuDetailModel: Decodable {
    let id: Int
    let name: String
    let price: Int
    let sequence: Int
    let files: [FoodImageModel]
}

struct FoodImageModel: Decodable {
    let url: String
}


//struct ReviewDetailModel: Decodable {
//
//}

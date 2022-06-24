//
//  RestaurantListData.swift
//  EatDa
//
//  Created by 김나희 on 5/31/22.
//

import Foundation

struct RestaurantListModel: Decodable {
    let id: Int?
    let name: String?
    let explanation: String?
    let imgUrl: String?
    let distance: Int?
    let hashTags: [String]
    let liked: Bool
}

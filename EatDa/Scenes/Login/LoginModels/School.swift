//
//  School.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/22.
//

import Foundation

struct SchoolData: Decodable {
    let id: Int?
    let region: Region?
    let name: String?
}

struct Region: Decodable {
    let id: Int?
    let sido: Int
    let sigungu: Int?
    let umd: Int?
    let name: String?
    let fullName: String?
    let coodinate: Coordinate?
}

struct Coordinate: Decodable {
    let latitude: Float?
    let longitude: Float?
}

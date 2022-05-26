//
//  Const.swift
//  EatDa
//
//  Created by 김나희 on 5/25/22.
//

import Foundation

struct Const {
    static var headerToken: String = TokenUtils.read(key: Const.KeyChainKey.accessToken) ?? ""
}

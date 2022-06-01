//
//  TokenUtils.swift
//  EatDa
//
//  Created by 김나희 on 5/25/22.
//

import Foundation
import Security

class TokenUtils {
    // MARK: 키체인 생성
    class func create(key: String, token: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key, // 저장할 account
            kSecValueData: token.data(using: .utf8, allowLossyConversion: false) as Any // 저장할 토큰
        ]
        SecItemDelete(query) // 키체인에 중복이 생기면 저장 불가 -> 삭제 먼저 진행
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "토큰 저장에 실패하였습니다.")
    }
    
    // MARK: 키체인 읽기
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any, //CFData로 불러오기
            kSecMatchLimit: kSecMatchLimitOne // 중복되는 경우, 하나의 값만 불러오기
        ]
        // CFData ?
        // AnyObject로 받고 데이터로 타입변환해서 사용하면 됨
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("\(status) 에러: 토큰 값 로딩에 실패하였습니다.")
            return nil
        }
    }
    
    // MARK: 키체인 삭제
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        
        let status = SecItemDelete(query)
        assert(status == noErr, "토큰 삭제에 실패하였습니다.")
    }

}

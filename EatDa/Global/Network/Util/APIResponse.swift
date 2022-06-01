//
//  APIResponse.swift
//  EatDa
//
//  Created by 김희진 on 2022/05/22.
//

import Foundation
import RxSwift
import Alamofire

enum APIError: Error {
    case failedTogetData
}

struct APIResponse<T: Decodable>: Decodable {
    let code: Int
    let data: T?
    let message: String?
}

struct APIConstants {
    // MARK: BASE URL
    static let BASE_URL = "http://api.foorun.co.kr"
    
    // MARK: SIGNUP/SIGNIN
    static let GET_SCHOOL_DATA = "/school"
    static let POST_SIGN_IN = "/member/sign-in"
    
    // MARK: HOME
    static let GET_RECOMMEND_RESTAURANT = "/restaurant"
    static let GET_AROUND_RESTAURANT = "/restaurant/near"

    // MARK: SEARCH
    static let GET_SEARCH_RESTAURANT = "/restaurant/search"

}

class API<T: Decodable> {
    var fetchURL: String
    var method: HTTPMethod
    var parameters: Parameters
    
    let headers: HTTPHeaders = [
        "Content-Type":"application/json",
        "Accept": "application/json",
        "Authorization": TokenUtils.read(key: Const.KeyChainKey.accessToken) ?? "",
        "X-Refresh-Token": TokenUtils.read(key: Const.KeyChainKey.refreshToken) ?? ""
    ]
    
    init (url: String, method: HTTPMethod, parameters: Parameters) {
        self.fetchURL = APIConstants.BASE_URL + url
        self.method = method
        self.parameters = parameters
    }
    
    func fetch(completion: @escaping (APIResponse<T>) -> Void) {
        var encodingType: ParameterEncoding {
            switch self.method {
            case .get, .delete:
                return URLEncoding.default
            case .post, .put:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }
        
        AF.request(self.fetchURL,
                   method: self.method,
                   parameters: self.parameters,
                   encoding: encodingType,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            if self.fetchURL == APIConstants.BASE_URL + APIConstants.POST_SIGN_IN {
                guard let accessToken = response.response?.allHeaderFields["Authorization"] as? String else { return }
                guard let refreshToken = response.response?.allHeaderFields["X-Refresh-Token"] as? String else { return }
                // 로그인 시 토큰 키체인에 저장
                TokenUtils.create(key: Const.KeyChainKey.accessToken, token: accessToken)
                TokenUtils.create(key: Const.KeyChainKey.refreshToken, token: refreshToken)
            }
            
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(APIResponse<T>.self, from: jsonData)
                    completion(result)
                } catch (let err){
                    print("네트워크 에러: ", err.localizedDescription)
                }
                
            case .failure(let error):
                print("네트워크 에러: ", error.localizedDescription)
            }
        }
    }
    
    func fetchWithRx() -> Observable<T> {
        return Observable.create { emitter in
            self.fetch() { result in
                guard result.data != nil else{
                    print("데이터가 존재하지 않습니다.")
                    return
                }
                emitter.onNext(result.data!)
            }
            return Disposables.create()
        }
    }

}

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
    static let BASE_URL = "http://api.foorun.co.kr"
    static let GET_SCHOOL_DATA = "/school"
}

class API<T: Decodable> {
    
    var fetchURL: String
    var method: HTTPMethod
    var parameters: Parameters
    
    let headers: HTTPHeaders = [
        "Content-Type":"application/x-www-from-urlencoded:utf-8",
        "Accept": "application/json"
    ]
    
    init (url: String, method: HTTPMethod, parameters: Parameters) {
        self.fetchURL = APIConstants.BASE_URL + url
        self.method = method
        self.parameters = parameters
    }
    
    func fetch(completion: @escaping (APIResponse<T>) -> Void) {
                
        AF.request(self.fetchURL,
                   method: self.method,
                   parameters: self.parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            
            switch response.result {
            case .success(let value):
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(APIResponse<T>.self, from: jsonData)
                   
                    completion(result)
                } catch (let err){
                    print(err.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

}

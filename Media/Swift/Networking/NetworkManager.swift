//
//  networkManager.swift
//  Media
//
//  Created by 이은서 on 2023/08/26.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "Bearer \(APIKey.tmdb)"]
    
    func callRequest<T: Codable>(codable: T, type: Endpoint, id: Int? = nil, completionHandler: @escaping (T) -> Void) {
        let url = type.requestURL(type: type, id: id)
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
//            guard let value = response.value else { return }
//            guard let statusCode = response.response?.statusCode else { return }
//            switch statusCode {
//            case 200..<300:
//                completionHandler(value)
//            default:
//                print(response.result)
//            }
        }
    }
}

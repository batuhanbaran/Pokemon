//
//  ApiManager.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let shared = ApiManager()
    
    func fetch<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: ApiPaths.baseUrl.rawValue + ApiPaths.endPoint.rawValue) else {
            return
        }
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    if let code = response.response?.statusCode {
                        switch code {
                        case 200:
                            do {
                                completion(.success(try JSONDecoder().decode(T.self, from: res)))
                            } catch let error {
                                print(String(data: res, encoding: .utf8) ?? "nothing received")
                                completion(.failure(error))
                            }
                        default:
                            let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

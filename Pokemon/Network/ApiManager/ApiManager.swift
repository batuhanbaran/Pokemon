//
//  ApiManager.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation
import Alamofire

class ApiManager: ApiManagerProtocol {
    
    static let shared = ApiManager()

    func fetch<T>(task: NetworkTask, completion: @escaping (Result<T, ErrorResponse>) -> Void) where T : Decodable {
        guard let url = URL(string: task.baseUrl + task.endpoint) else { return }
        AF.request(url,
                   method: task.method,
                   headers: task.headers)
            .responseData { response in
                if let code = response.response?.statusCode {
                    let httpStatusCode = HTTPStatusCode(rawValue: code)
                    
                    switch httpStatusCode {
                    case .ok:
                        switch response.result {
                        case .success(let res):
                            do {
                                completion(.success(try JSONDecoder().decode(T.self, from: res)))
                            } catch {
                                completion(.failure(.decode("Decoding Error!")))
                            }
                        case .failure(_):
                            completion(.failure(.decode("ddf")))
                        }
                    case .notFound:
                        completion(.failure(.notFound("404 Not Found!")))
                    case .unauthorized:
                        completion(.failure(.unauthorized("Unauthorized Access!")))
                        
                    default:
                        print("asd")
                    }
                }
            }
    }
}

//
//  NetworkTask.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation
import Alamofire

class NetworkTask: NetworkTaskProtocol {

    var baseUrl: String
    var endpoint: String
    var headers: HTTPHeaders
    var method: HTTPMethod
    
    init(baseUrl: String, endpoint: String, headers: HTTPHeaders, method: HTTPMethod) {
        self.baseUrl = baseUrl
        self.endpoint = endpoint
        self.headers = headers
        self.method = method
    }
}

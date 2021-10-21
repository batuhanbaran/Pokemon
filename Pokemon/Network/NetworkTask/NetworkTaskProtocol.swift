//
//  NetworkTaskProtocol.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation
import Alamofire

protocol NetworkTaskProtocol {
    var baseUrl: String { get set }
    var endpoint: String { get set }
    var headers: HTTPHeaders { get set }
    var method: HTTPMethod { get set }
}

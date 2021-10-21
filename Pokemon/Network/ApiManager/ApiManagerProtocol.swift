//
//  ApiManagerProtocol.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation

protocol ApiManagerProtocol {
    func fetch<T>(task: NetworkTask, completion: @escaping (Result<T, ErrorResponse>) -> Void) where T: Decodable
}

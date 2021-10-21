//
//  PokemonTask.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 20.10.2021.
//

import Foundation
import Alamofire

class PokemonTask: NetworkTask {
    
    var limit: Int = 0
    var offset: Int = 0
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        super.init(baseUrl: ApiPaths.baseUrl.rawValue, endpoint: ApiPaths.endPoint.rawValue + "/?limit=\(limit)&offset=\(offset)", headers: ["Content-Type":"application/json"], method: .get)
    }
}

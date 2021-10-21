//
//  ItemTableViewCellData.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import Foundation

class ItemTableViewCellData: GenericDataProtocol {
    
    private(set) var pokemonName: String
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
    }
}

//
//  PokemonSpritesTask.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 22.10.2021.
//

import Foundation

class PokemonSpritesTask: NetworkTask {
    
    init(selectedPokemonUrl: String) {
        super.init(baseUrl: selectedPokemonUrl, headers: ["Content-Type":"application/json"], method: .get)
    }
}

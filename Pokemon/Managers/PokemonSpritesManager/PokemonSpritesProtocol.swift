//
//  PokemonSpritesProtocol.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation
import RxSwift

protocol PokemonSpritesProtocol {
    
    var pokemonSpritesTask: PokemonSpritesTask? { get set }
    
    func fetchPokemonSprites(selectedPokemonUrl: String)
    
    func subscribePokemonPublisher(with completion: @escaping PokemonSpriteResultBlock) -> Disposable
}


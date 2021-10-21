//
//  PokemonListProtocol.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import RxSwift

typealias PokemonListResult = (Result<PokemonResult, ErrorResponse>) -> Void

protocol PokemonListProtocol {
    
    var pokemonTask: PokemonTask? { get set }
    
    func fetchPokemons(offset: Int, limit: Int)
    
    func subscribePokemonPublisher(with completion: @escaping PokemonListResult) -> Disposable
}

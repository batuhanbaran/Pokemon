//
//  PokemonListManager.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import Foundation
import RxSwift

class PokemonListManager: PokemonListProtocol {

    typealias PokemonListResult = Result<PokemonResult, ErrorResponse>
    typealias PokemonListResultBlock = (Result<PokemonResult, ErrorResponse>) -> Void
    
    var pokemonTask: PokemonTask?
    var publishedPokemons = PublishSubject<PokemonListResult>()
    
    static let shared = PokemonListManager()

    func fetchPokemons(offset: Int, limit: Int) {
        ApiManager.shared.fetch(task: PokemonTask(limit: limit, offset: offset)) { (result: PokemonListResult) in
            switch result {
            case .success(_):
                self.publishedPokemons.onNext(result)
            case .failure(let erroResponse):
                print(erroResponse)
            }
        }
    }
    
    func subscribePokemonPublisher(with completion: @escaping PokemonListResultBlock) -> Disposable {
        return publishedPokemons.subscribe(onNext: completion)
    }
}

//
//  PokemonSpritesManager.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation
import RxSwift
import RxCocoa

typealias PokemonSpriteResult = Result<Sprites, ErrorResponse>
typealias PokemonSpriteResultBlock = (Result<Sprites, ErrorResponse>) -> Void

class PokemonSpritesManager: PokemonSpritesProtocol {
    
    var pokemonSpritesTask: PokemonSpritesTask?
    var publishedSprites = PublishSubject<PokemonSpriteResult>()
    
    static let shared = PokemonListManager()
    
    func fetchPokemonSprites(selectedPokemonUrl: String) {
        pokemonSpritesTask = PokemonSpritesTask(selectedPokemonUrl: selectedPokemonUrl)
        guard let pokemonSpritesTask = pokemonSpritesTask else { return }
    
        ApiManager.shared.fetch(task: pokemonSpritesTask ) { (result: PokemonSpriteResult) in
            switch result {
            case .success(_):
                self.publishedSprites.onNext(result)
            case .failure(let errorResponse):
                print("error: \(errorResponse)")
            }
        }
    }
    
    func subscribePokemonPublisher(with completion: @escaping PokemonSpriteResultBlock) -> Disposable {
        return self.publishedSprites.subscribe(onNext: completion)
    }
}

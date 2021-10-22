//
//  PokemonDetailViewModel.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class PokemonDetailViewModel {
    
    private let spriteManager: PokemonSpritesManager
    
    var pageLoadingStatus = BehaviorRelay<PageLoadingStatus>(value: .loading)
    var selectedPokemon: Pokemon
    var sprite: Sprites?
    var spriteUrls = [String]()
    
    let disposeBag = DisposeBag()
    
    init(selectedPokemon: Pokemon,spriteManager: PokemonSpritesManager) {
        self.selectedPokemon = selectedPokemon
        self.spriteManager = spriteManager
        subscribeManagerPublisher()
    }
    
    func fetchSprites() {
        guard let selectedPokemonUrl = selectedPokemon.url else { return }
        spriteManager.fetchPokemonSprites(selectedPokemonUrl: selectedPokemonUrl)
    }
    
    func subscribeManagerPublisher() {
        self.pageLoadingStatus.accept(.loading)
        spriteManager.subscribePokemonPublisher { [weak self] spritesResult in
            guard let self = self else { return }
            switch spritesResult {
            case let .success(sprites):
                self.sprite = sprites
                guard let data = sprites.sprites else { return }
                self.handleSpritesUrls(data: data)
            case let .failure(errorResponse):
                self.pageLoadingStatus.accept(.error(errorResponse))
            }
        }.disposed(by: disposeBag)
    }
    
    func handleSpritesUrls(data: Sprite) {
        self.spriteUrls.append(data.back_default ?? "")
        self.spriteUrls.append(data.back_shiny ?? "")
        self.spriteUrls.append(data.back_female ?? "")
        self.spriteUrls.append(data.back_shiny_female ?? "")
        self.spriteUrls.append(data.front_default ?? "")
        self.spriteUrls.append(data.front_shiny ?? "")
        self.spriteUrls.append(data.front_shiny_female ?? "")
        self.spriteUrls = self.spriteUrls.filter({ $0 != ""})
        
        self.pageLoadingStatus.accept(.success)
    }
}

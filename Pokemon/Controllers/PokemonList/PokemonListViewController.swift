//
//  PokemonListViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import UIKit
import RxSwift
import RxRelay

class PokemonListViewController: BaseViewController<PokemonListViewModel> {

    private var mainComponent: ItemListView!
    internal let disposeBag = DisposeBag()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        addFavoriteBarButton()
        addMainComponent()
        bindStatus()
        bindTitle()
        fetchPokemons()
    }
    
    private func addMainComponent() {
        mainComponent = ItemListView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        
        mainComponent.delegate = viewModel
        viewModel.delegate = self
        
        view.addSubview(mainComponent)
        
        NSLayoutConstraint.activate([
        
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    private func fetchPokemons() {
        viewModel.fetchPokemons()
        self.mainComponent.reloadTableView()
    }
    
    private func bindTitle() {
        viewModel.currentPokemonCount
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                guard let self = self else { return }
                self.title = "\(count) pokemons in \(self.viewModel.totalPokemonCount)"
            })
            .disposed(by: disposeBag)
    }
    
    private func addFavoriteBarButton() {
        let barButton = UIBarButtonItem(image: TabBarImages.logout.value, style: .plain, target: self, action: #selector(favoriteButtonAction))
        barButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func favoriteButtonAction() {
        viewModel.logout()
    }
}

extension PokemonListViewController: PokemonListViewModelOutputDelegate {
    func navigateToPokemonDetail(with selectedPokemon: Pokemon) {
        let spriteManager = PokemonSpritesManager()
        let pokemonDetailViewModel = PokemonDetailViewModel(selectedPokemon: selectedPokemon, spriteManager: spriteManager)
        let pokemonDetailVC = PokemonDetailViewController(viewModel: pokemonDetailViewModel, lottieName: "loading")
        pokemonDetailVC.title = selectedPokemon.name?.capitalizingFirstLetter() ?? ""
        self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
    func hasMoreLoaded() {
        DispatchQueue.main.async {
            self.mainComponent.reloadTableView()
        }
    }
}

extension PokemonListViewController: StatusProtocol {
    func bindStatus() {
        viewModel.pageLoadingStatus
            .subscribe(onNext: { [weak self] pageLoadingStatus in
                guard let self = self else { return }
                switch pageLoadingStatus {
                case .loading:
                    DispatchQueue.main.async {
                        self.view.alpha = 0.75
                        self.lottieView.play()
                    }
                case .success:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.view.alpha = 1
                        self.lottieView.stop()
                    }
                    self.mainComponent.reloadTableView()
                case let .error(error):
                    print("error: \(error)")
                }
            })
            .disposed(by: disposeBag)
    }
}

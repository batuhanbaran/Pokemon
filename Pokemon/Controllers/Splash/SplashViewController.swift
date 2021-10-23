//
//  SplashViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: BaseViewController<SplashViewModel> {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 227 / 255, green: 52 / 255, blue: 47 / 255, alpha: 1)
        
        lottieView.delegate = self
        bindStatus()
        lottieView.play()
    }
}

extension SplashViewController: LottieViewOutputDelegate {
    func navigateToMainView() {
        viewModel.checkUserisLoggedIn()
    }
}

extension SplashViewController: StatusProtocol {
    func bindStatus() {
        viewModel.isLoggedIn
            .subscribe(onNext: { [weak self] loginStatus in
                guard let self = self else { return }
                switch loginStatus {
                case true:
                    var pokemonListVC = BaseBuilder<PokemonListViewController>().build(with: .fullScreen)
                    let manager = PokemonListManager()
                    pokemonListVC = PokemonListViewController(viewModel: PokemonListViewModel(manager: manager), lottieName: "loading")
                    let pokemonListNavigationVC = UINavigationController(rootViewController: pokemonListVC)
                    pokemonListNavigationVC.modalPresentationStyle = .fullScreen

                    self.present(pokemonListNavigationVC, animated: false)
                case false:
                    let manager = AuthenticationManager.shared
                    let loginVC = LoginViewController(viewModel: LoginViewModel(authenticationManager: manager))
                    loginVC.title = "Login"
                    let loginNavigationVC = UINavigationController(rootViewController: loginVC)
                    loginNavigationVC.modalPresentationStyle = .fullScreen
                    self.lottieView.stop()
                    
                    self.present(loginNavigationVC, animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
}

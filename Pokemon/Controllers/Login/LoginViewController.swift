//
//  LoginViewController.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 23.10.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController<LoginViewModel> {
    
    private var authenticationView: LoginAuthenticationView!
    let disposeBag = DisposeBag()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        addAuthenticationView()
    
    }
    
    private func addAuthenticationView() {

        authenticationView = LoginAuthenticationView(data: viewModel.getLoginViewData())
        authenticationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(authenticationView)
        
        NSLayoutConstraint.activate([
        
            authenticationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authenticationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authenticationView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
        ])
    }
}

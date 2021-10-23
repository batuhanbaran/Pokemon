//
//  LoginViewModel.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 23.10.2021.
//

import Foundation
import RxSwift
import RxCocoa

typealias VoidBlock = () -> Void

class LoginViewModel {
    
    private let authenticationManager: AuthenticationManagerProtocol
    let isLoggedIn = BehaviorRelay<Bool>(value: false)
    
    init(authenticationManager: AuthenticationManagerProtocol) {
        self.authenticationManager = authenticationManager
    }
    
    func getLoginViewData() -> LoginAuthenticationViewData {
        return LoginAuthenticationViewData(actionButtonData: ActionButtonData(text: "Login", buttonType: .outlined(.black)).setActionButtonListener(by: loginActionButtonListener), emailLoginViewData: EmailLoginViewData(email: TextFieldViewData(placeHolder: "Email"), password: TextFieldViewData(placeHolder: "Password")))
    }
    
    private func fireSignIn() {
        authenticationManager.signIn(with: SimpleAuthenticationRequest(email: "admin@admin.com", password: "123456"))
    }
    
    private lazy var loginActionButtonListener: VoidBlock = { [weak self] in
        self?.fireSignIn()
    }
}

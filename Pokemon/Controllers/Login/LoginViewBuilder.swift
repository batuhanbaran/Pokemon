//
//  LoginViewBuilder.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 23.10.2021.
//

import Foundation
import UIKit

class LoginViewBuilder {
    
    class func build() -> UIViewController {
        let authenticationManager = AuthenticationManager.shared
        let viewModel = LoginViewModel(authenticationManager: authenticationManager)
        return LoginViewController(viewModel: viewModel)
    }
    
}

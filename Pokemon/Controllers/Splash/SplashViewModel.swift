//
//  SplashViewModel.swift
//  Pokemon
//
//  Created by Batuhan BARAN on 23.10.2021.
//

import Foundation
import FirebaseAuth
import RxSwift
import RxCocoa

class SplashViewModel {
    
    let isLoggedIn = BehaviorRelay<Bool>(value: false)
    
    func checkUserIsLoggedIn() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.isLoggedIn.accept((user == nil) ? false : true)
        }
    }
}

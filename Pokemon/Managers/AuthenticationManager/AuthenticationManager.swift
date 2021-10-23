//
//  AuthenticationManager.swift
//  WeatherApplication
//
//  Created by Erkut Bas on 16.10.2021.
//

import Foundation
import FirebaseAuth

class AuthenticationManager: AuthenticationManagerProtocol {
    
    public static let shared = AuthenticationManager()
    
    private init() { }
    
    
    func signIn(with request: SimpleAuthenticationRequest) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) { authDataResult, error in
            if error != nil {
                print("Error : \(error)")
            }
            print("data : \(authDataResult)")
            print("break")
        }
        
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("error : \(error)")
        }
    }
    
}

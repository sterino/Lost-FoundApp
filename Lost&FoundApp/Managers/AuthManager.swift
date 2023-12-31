//
//  AuthManager.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 19.12.2023.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    let facade: NetworkFacade = NetworkFacade()

    private let baseURL = "https://fastapi-xhpv.onrender.com"
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private init() {}

    func signIn(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        facade.signIn(username: username, password: password, completion: completion)
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        UserDefaults.standard.removeObject(forKey: "access_token")
    }
    
    func signUp(name: String, username: String, password: String, completion: @escaping (Result<String, Error>) -> Void){
        
    }
}


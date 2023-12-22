//
//  AuthManager.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 19.12.2023.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    private let baseURL = "https://fastapi-xhpv.onrender.com"
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private init() {}

    func signIn(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else{
            completion(.failure(NSError(domain: "Invalidadsa", code: 0)))
            return
        }
        
        let url = URL(string: "\(baseURL)/auth/users/tokens")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "username=\(username)&password=\(password)"
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let accessToken = json["access_token"] as? String {
                print(accessToken)
                UserDefaults.standard.set(accessToken, forKey: "access_token")
                completion(.success(accessToken))
            } else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 0)))
            }
        }
        task.resume()
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        UserDefaults.standard.removeObject(forKey: "access_token")
    }
    
    func signUp(name: String, username: String, password: String, completion: @escaping (Result<String, Error>) -> Void){
        let url = "\(baseURL)/auth/users"
        
        
    }
}


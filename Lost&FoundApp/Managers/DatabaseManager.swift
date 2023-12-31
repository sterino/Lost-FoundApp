//
//  DatabaseManager.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 19.12.2023.
//
import Foundation

public enum RequestResult {
    case success(String)
    case error(Error)
}

final class DatabaseManager {
    static let shared = DatabaseManager()

    let facade: NetworkFacade = NetworkFacade()

    private init() {}

    public func createAd(type: Int, title: String, description: String, category: String, completion: @escaping (RequestResult) -> Void) {
        facade.createAd(type: type, title: title, description: description, category: category) { responseString, error in
            if let error {
                completion(.error(error))
            } else if let responseString {
                completion(.success(responseString))
            }
        }
    }


    
    public func getAllAds(){
        
    }
    
    public func getAd(){
        
    }
    
}

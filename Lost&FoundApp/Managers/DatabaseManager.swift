//
//  DatabaseManager.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 19.12.2023.
//
import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()

    private let baseURL = "https://fastapi-xhpv.onrender.com/ads"
    private let accessTokenKey = "accessToken" // Key for UserDefaults

    private init() {}

    public func createAd(type: Int, title: String, description: String, category: String) {
        guard let accessToken = UserDefaults.standard.string(forKey: accessTokenKey) else {
            print("Access token not found in UserDefaults.")
            return
        }

        // Prepare request data
        let requestData: [String: Any] = [
            "type": type,
            "title": title,
            "description": description,
            "category": category
        ]

        // Convert request data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            print("Failed to convert data to JSON.")
            return
        }

        // Create URL request
        guard let url = URL(string: baseURL) else {
            print("Invalid URL.")
            return
        }


        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData

        // Create URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle response
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                // Parse response data if needed
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
            }
        }

        task.resume()
        
        
    }



    
    public func getAllAds(){
        
    }
    
    public func getAd(){
        
    }
    
}

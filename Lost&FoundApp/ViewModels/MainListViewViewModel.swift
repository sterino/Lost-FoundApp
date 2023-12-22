//
//  MainListViewViewModel.swift
//  Lost&FoundApp
//
//  Created by Aibatyr on 16.12.2023.
//

import UIKit

final class MainListViewViewModel: NSObject {

    private let baseURL = "https://fastapi-xhpv.onrender.com"

    func fetchCharacters(completion: @escaping (Int?, [Ads]?) -> Void) {
        let url = URL(string: "https://fastapi-xhpv.onrender.com/ads")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil, nil)
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let adsList = try decoder.decode(GetAdsResponse.self, from: data)
                            let total = adsList.total
                            let ads = adsList.ads
                            completion(total, ads)
                        } catch {
                            print("Error decoding JSON: \(error)")
                            completion(nil, nil)
                        }
                    }
                } else {
                    print("Unexpected status code: \(response.statusCode)")
                    completion(nil, nil)
                }
            }
        }

        task.resume()
    }
}

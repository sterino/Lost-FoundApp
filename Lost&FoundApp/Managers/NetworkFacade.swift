

import Foundation
import UIKit

final class NetworkFacade {
    private let baseURL = "https://fastapi-xhpv.onrender.com"
    private let accessTokenKey = "accessToken" // Key for UserDefaults

    init() {}

    public func createAd(type: Int, title: String, description: String, category: String, completion: @escaping (String?, Error?) -> Void) {
        guard let accessToken = UserDefaults.standard.string(forKey: "access_token") else {
            print("Access token not found in UserDefaults.")
            completion(nil, NSError(domain: "com.yourapp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Access token not found in UserDefaults."]))
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
            completion(nil, NSError(domain: "com.yourapp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to JSON."]))
            return
        }

        // Create URL request
        guard let url = URL(string: "\(baseURL)/ads/create") else {
            print("Invalid URL.")
            completion(nil, NSError(domain: "com.yourapp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."]))
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
                completion(nil, error)
                return
            }

            if let data = data {
                // Parse response data if needed
                if let responseString = String(data: data, encoding: .utf8) {
                    do {
                        if let jsonData = responseString.data(using: .utf8) {
                            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                if let ad_id = jsonObject["new_post_id"] as? String {
                                    // Присвоить значение ad_id переменной
                                    completion(ad_id, nil)
                                    print(ad_id)
                                } else {
                                    print("Не удалось извлечь значение для ключа 'new_post_id'")
                                }
                            } else {
                                print("Не удалось преобразовать JSON в объект [String: Any]")
                            }
                        } else {
                            print("Не удалось преобразовать строку в данные в кодировке UTF-8")
                        }
                    } catch {
                        print("Ошибка при обработке JSON: \(error.localizedDescription)")
                    }
                    
                } else {
                    completion(nil, NSError(domain: "com.yourapp", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response data."]))
                }
            } else {
                completion(nil, NSError(domain: "com.yourapp", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received in the response."]))
            }
        }

        task.resume()
    }
    
    public func signIn(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
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
    
    func uploadImage(image: UIImage?, adId: String) {
          let apiUrl = "https://fastapi-xhpv.onrender.com/ads/\(adId)/media/"  // Обновленный URL

                  guard let imageData = image?.jpegData(compressionQuality: 1.0) else {
                      return
                  }

                  guard let accessToken = UserDefaults.standard.string(forKey: "access_token") else {
                      return
                  }

                  let url = URL(string: apiUrl)!

                  // Добавляем "ad_id" к URL
                  var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                  components?.queryItems = [URLQueryItem(name: "ad_id", value: adId)]

                  guard let finalURL = components?.url else {
                      print("Не удалось создать конечный URL")
                      return
                  }

                  var request = URLRequest(url: finalURL)
                  request.httpMethod = "POST"
                  request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

                  let boundary = UUID().uuidString
                  request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

                  var body = Data()

                  body.append("--\(boundary)\r\n".data(using: .utf8)!)
                  body.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                  body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                  body.append(imageData)
                  body.append("\r\n".data(using: .utf8)!)

                  body.append("--\(boundary)\r\n".data(using: .utf8)!)
                  body.append("Content-Disposition: form-data; name=\"ad_id\"\r\n\r\n".data(using: .utf8)!)
                  body.append(adId.data(using: .utf8)!)
                  body.append("\r\n".data(using: .utf8)!)

                  body.append("--\(boundary)--\r\n".data(using: .utf8)!)

                  request.httpBody = body

             
             URLSession.shared.dataTask(with: request) { data, response, error in
                 if let error = error as NSError?, error.code == 307 {
                     // Обработка ошибки 307 - временное перенаправление
                     if let newURLString = (response as? HTTPURLResponse)?.value(forHTTPHeaderField: "Location"),
                        let newURL = URL(string: newURLString) {
                         // Повторный запрос по новому URL
                         self.uploadImage(image: image, adId: adId)
                     } else {
                         print("Ошибка 307, но новый URL не найден.")
                     }
                 } else if let error = error {
                     print("Error:", error)
                 } else if let data = data {
                     // Обработка успешного ответа
                     let responseString = String(data: data, encoding: .utf8)
                     print("Success:", responseString ?? "")
                 }
             }.resume()
         }
  
}

//
//  APICall.swift
//  MobilniAplikace
//
//  Created by Lukáš on 16.12.2023.
//

import Foundation

class APICall {
    static let shared = APICall()
    
    private init() {}
    
    func fetchCelebrity(forName name: String, completion: @escaping (Result<Celebrity, Error>) -> Void) {
        let escapedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "https://api.api-ninjas.com/v1/celebrity?name=" + (escapedName ?? "")
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.setValue("vePOXI4H5nHmbvg1x/yhnA==YoOxSXff2H9ngh1Q", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let celebrities = try decoder.decode([Celebrity].self, from: data)
                    
                    // Se vrati plny apicall
                    if let firstCelebrity = celebrities.first {
                        completion(.success(firstCelebrity))
                    } else {
                        //Prazdny apicall
                        completion(.failure(NSError(domain: "No celebrity found", code: 404, userInfo: nil)))
                    }
                } catch let decodingError as DecodingError {
                    print("DecodingError: \(decodingError)")
                    completion(.failure(decodingError))
                } catch {
                    print("Error při dekódování: \(error)")
                    completion(.failure(error))
                }
                
                print("API Response:\n\(String(data: data, encoding: .utf8)!)")
            }
        }
        
        task.resume()
    }
}

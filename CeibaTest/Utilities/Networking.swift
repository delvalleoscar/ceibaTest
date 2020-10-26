//
//  Networking.swift
//  CeibaTest
//
//  Created by Oscar del Valle Ruiz on 25/10/20.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodeError
    case other(error: Error?)
    
    var description: String {
        return String(reflecting: self)
    }
    
}

struct Networking {
    static func get<T>(with path: String, completionHandler: @escaping
                        (Result<[T], NetworkError>) -> Void) where T : Decodable {
        guard let url = URL(string: path) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (requestData, _, error) in
            guard let data = requestData, error == nil else {
                completionHandler(.failure(.other(error: error)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([T].self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
}

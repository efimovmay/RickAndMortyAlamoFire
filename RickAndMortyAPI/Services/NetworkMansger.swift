//
//  NetworkMansger.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 14.03.2023.
//

import Foundation

enum link: String{
    case allCharacter = "https://rickandmortyapi.com/api/character/"
    case location = "https://rickandmortyapi.com/api/location/"
    case episode = "https://rickandmortyapi.com/api/episode/"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManger {
    static let shared = NetworkManger()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(dataType: T.Type, from url: String? , completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

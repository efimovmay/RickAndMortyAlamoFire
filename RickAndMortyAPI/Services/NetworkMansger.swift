//
//  NetworkMansger.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 14.03.2023.
//

import Foundation
import Alamofire

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
    
    func fetch(from url: String, completion: @escaping(Result<AllCharacter, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let allCharacterData = value as? [String: Any] else { return }
                    let allCharacter = AllCharacter(allCharacterData: allCharacterData)
                    completion(.success(allCharacter))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    func fetchCharacter(from url: String, completion: @escaping(Result<Character, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let characterData = value as? [String: Any] else { return }
                    let character = Character(characterData: characterData)
                    completion(.success(character))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
}

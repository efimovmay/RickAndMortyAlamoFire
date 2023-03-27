//
//  Person.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 10.03.2023.
//

import Foundation

struct AllCharacter: Decodable {
    let info: Info
    let results: [Character]
    
    init(value: [String: Any]) {
        let infoData = value["info"] as? [String: Any] ?? [:]
        info = Info(infoData: infoData)
        let result = value["results"] as? [[String: Any]] ?? [[:]]
        results = Character.getCharacters(from: result)
    }
    
    static func getAllCharacter(from value: Any) -> AllCharacter? {
        guard let value = value as? [String: Any] else { return nil }
        let allCharacter =  AllCharacter(value: value)
        return allCharacter
    }
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
    
    init(infoData: [String: Any]) {
        count = infoData["count"] as? Int
        pages = infoData["pages"] as? Int
        next = infoData["next"] as? String
        prev = infoData["prev"] as? String
    }
}
struct Character: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    var description: String {
        """
        Status: \(status ?? "")
        Species \(species ?? "")
        Type: \(type ?? "")
        Gender: \(gender ?? "na")
        """
    }
    
    init(characterData: [String: Any]) {
        id = characterData["id"] as? Int
        name = characterData["name"] as? String
        status = characterData["status"] as? String
        species = characterData["species"] as? String
        type = characterData["type"] as? String
        gender = characterData["gender"] as? String
        let originDict = characterData["origin"] as? [String: Any] ?? [:]
        origin = Origin(originData: originDict)
        let locationDict = characterData["location"] as? [String: Any] ?? [:]
        location = Location(locationData: locationDict)
        image = characterData["image"] as? String
        episode = characterData["episode"] as? [String]
        url = characterData["url"] as? String
        created = characterData["created"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let characterData = value as? [[String: Any]] else { return []}
        return characterData.compactMap { Character(characterData: $0) }
    }
}

struct Origin: Decodable {
    let name: String?
    let url: String?
    
    init(originData: [String: Any]) {
        name = originData["name"] as? String
        url = originData["url"] as? String
    }
}

struct Location: Decodable {
    let name: String?
    let url: String?
    
    init(locationData: [String: Any]) {
        name = locationData["name"] as? String
        url = locationData["url"] as? String
    }
}

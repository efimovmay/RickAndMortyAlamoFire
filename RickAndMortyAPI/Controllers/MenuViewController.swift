//
//  MenuViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 10.03.2023.
//

import UIKit



class MenuViewController: UIViewController {
    
    var randomCharacter: Character?
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showAllCharacter" {
            guard let allCharacterVC = segue.destination as? AllCharacterCollectionViewController else { return }
            allCharacterVC.fetchCharacter(from: link.allCharacter.rawValue)
        } else if segue.identifier == "showRandomCharacter" {
            guard let infoCharacterVC = segue.destination as? InfoCharacterViewController else { return }
            infoCharacterVC.character = randomCharacter
        }
    }
    
    @IBAction func randomCharacterButtonPressed() {
        let link = link.allCharacter.rawValue + String(Int.random(in: 1...826))
        fetchRandomCharacter(from: link)
        performSegue(withIdentifier: "showRandomCharacter", sender: nil)
    }
    
    private func fetchRandomCharacter(from link: String) {
        NetworkManger.shared.fetch(dataType: Character.self, from: link) { [weak self] result in
            switch result {
            case .success(let character):
                self?.randomCharacter = character
                print(character)
            case .failure(let error):
                print(error)
            }
        }
    }
}






//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 10.03.2023.
//

import UIKit



class ViewController: UIViewController {
     
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllCharacter" {
            guard let allCharacterVC = segue.destination as? AllCharacterCollectionViewController else { return }
            allCharacterVC.fetchCharacter()
        }
    }
}



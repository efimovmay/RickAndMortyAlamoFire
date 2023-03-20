//
//  InfoCharacterViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 15.03.2023.
//

import Foundation
import UIKit

class InfoCharacterViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ststusLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var characterImage: UIImageView!
    
    var character: Character!
//    var linkCharacter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = character.name
        
        NetworkManger.shared.fetchImage(from: character.image) { [weak self] Result in
            switch Result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        ststusLabel.text = "Status: " + (character.status ?? "")
        speciesLabel.text = "Species: " + (character.species ?? "")
        typeLabel.text = "Type: " + (character.type ?? "")
        genderLabel.text = "Gender: " + (character.gender ?? "")
    }
}
// MARK: - Networking

//extension AllCharacterCollectionViewController {
//    func fetchCharacte(from link: String) {
//        NetworkManger.shared.fetch(dataType: Character.self, from: link) { [weak self] result in
//            switch result {
//            case .success(let character):
//                self?.character = character
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}

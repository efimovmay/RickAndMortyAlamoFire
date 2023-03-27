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
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var characterImage: UIImageView!
    
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = character?.name
        infoLabel.text = character?.description
        characterImage.layer.cornerRadius = 10
        fetchImage(from: character?.image)
    }
}

// MARK: - Networking

extension InfoCharacterViewController {
    
    func fetchImage(from link: String?) {
        NetworkManger.shared.fetchImage(from: link) { [weak self] Result in
            switch Result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRandomCharacter(from link: String) {
        NetworkManger.shared.fetchCharacter(from: link) { [weak self] result in
            switch result {
            case .success(let characterData):
                self?.character = characterData
                self?.setupUI()
            case .failure(let error):
                print(error)
            }
        }
    }
}

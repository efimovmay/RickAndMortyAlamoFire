//
//  AllCharacterCollectionViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 14.03.2023.
//

import UIKit


class AllCharacterCollectionViewController: UICollectionViewController {

    private var allCharacter = AllCharacter(info: nil, results: [])
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allCharacter.results?.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CharacterCollectionViewCell
        else { return UICollectionViewCell() }
        
        let character = allCharacter.results![indexPath.row]
        
        cell.configur(whith: character)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: - Networking

extension AllCharacterCollectionViewController {
    func fetchCharacter() {
        NetworkManger.shared.fetch(dataType: AllCharacter.self, from: link.allCharacter.rawValue) { [weak self] result in
            switch result {
            case .success(let allCharacter):
                self?.allCharacter = allCharacter
                self?.collectionView.reloadData()
                print(allCharacter.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}

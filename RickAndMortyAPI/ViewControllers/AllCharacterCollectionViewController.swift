//
//  AllCharacterCollectionViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 14.03.2023.
//

import UIKit


class AllCharacterCollectionViewController: UICollectionViewController {

    
    @IBOutlet var prevButton: UIBarButtonItem!
    @IBOutlet var nextButton: UIBarButtonItem!
    
    private var allCharacter = AllCharacter(info: nil, results: [])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "infoCharacter" {
//            guard let infoCharacterVC = segue.destination as? InfoCharacterViewController else { return }
//            infoCharacterVC.character = allCharacter.results
//        }
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "infoCharacter", sender: nil)
//
//    }
    
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
    
    //MARK: - Navigation
    
    @IBAction func nextPageButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            guard let linkNextPages = allCharacter.info?.prev else { return }
            fetchCharacter(from: linkNextPages)
        default:
            guard let linkNextPages = allCharacter.info?.next else { return }
            fetchCharacter(from: linkNextPages)
        }
        setupButton()
    }
    
    private func setupButton() {
        if allCharacter.info?.prev == nil {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
}

// MARK: - CollectionViewDeligateFlowLayout

extension AllCharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberCellInRow: CGFloat = 2
        let padingWidht = 5 * ( numberCellInRow )
        let availableWidht = collectionView.frame.width - padingWidht
        let cellWidht = availableWidht/numberCellInRow
        let cellHight = cellWidht + 16
        return CGSize(width: cellWidht, height: cellHight)
    }
}

// MARK: - Networking

extension AllCharacterCollectionViewController {
    func fetchCharacter(from link: String) {
        NetworkManger.shared.fetch(dataType: AllCharacter.self, from: link) { [weak self] result in
            switch result {
            case .success(let allCharacter):
                self?.allCharacter = allCharacter
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 10.03.2023.
//

import UIKit

enum StutusAlert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success: return "Success"
        case .failed: return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success: return  "You can see the results in the Debug aria"
        case .failed: return "You can see error in the Debug aria"
        }
    }
}

class ViewController: UIViewController {
     
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllCharacter" {
            guard let allCharacterVC = segue.destination as? AllCharacterCollectionViewController else { return }
            allCharacterVC.fetchCharacter()
        }
    }
    
    @IBAction func fetchData() {

        
//        guard let url = URL(string: link.randomCharacter.rawValue) else { return }
//
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error descripcion")
//                return
//            }
//
//            let jsonDecoder = JSONDecoder()
//
//            do {
//                let person = try jsonDecoder.decode(Character.self, from: data)
//                print(person)
//                DispatchQueue.main.async {
//                    self?.showAlert(stutus: .success)
//                }
//            } catch {
//                print(error.localizedDescription)
//                DispatchQueue.main.async {
//                    self?.showAlert(stutus: .failed)
//                }
//            }
//        }.resume()
        
    }
    
    private func showAlert(stutus: StutusAlert) {
        let alert = UIAlertController(
                title: stutus.title,
                message: stutus.message,
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
    }
}



//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Aleksey Efimov on 10.03.2023.
//

import UIKit

class ViewController: UIViewController {

    let url = "https://rickandmortyapi.com/api/character/"
     
    
    @IBAction func fetchData() {
        let randomChracter = String(Int.random(in: 1...826))
        guard let url = URL(string: (url + randomChracter)) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error descripcion")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let person = try jsonDecoder.decode(Character.self, from: data)
                print(person)
                self.successAlert()
            } catch {
                print(error.localizedDescription)
                self.failedAlert()
            }
        }.resume()
        
    }
    
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}


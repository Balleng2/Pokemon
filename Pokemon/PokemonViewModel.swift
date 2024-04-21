//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import SwiftUI

enum AppState: Int {
    case loading
    case pokemon_loaded
    case error_loading
}

class PokemonViewModel: ObservableObject {
    
    @Published var listOfPokemon = [Pokemon_List]()
    @Published var appState = AppState.loading

    func fetchList() async {
        let urlRequest = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0")!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let dataDecoded = try JSONDecoder().decode(AllResults.self, from: data)
                DispatchQueue.main.async {
                    self.listOfPokemon = dataDecoded.results
                    self.appState = .pokemon_loaded
                }
            } catch {
                DispatchQueue.main.async {
                    self.appState = .error_loading
                }
            }
        }
        dataTask.resume()
    }
}

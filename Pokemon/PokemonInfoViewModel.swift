//
//  PokemonInfoViewModel.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import Foundation

enum InfoState: Int {
    case loading
    case finished
    case error
}

class PokemonInfoViewModel: ObservableObject {
    @Published var pokemonInfo: PokemonInfo?
    @Published var infoState: InfoState
    
    init(infoState: InfoState) {
        self.infoState = infoState
    }
    
    func fetchPokemonInfo(_ url: String) async {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let dataDecoded = try JSONDecoder().decode(PokemonInfo.self, from: data)
                DispatchQueue.main.async {
                    self.pokemonInfo = dataDecoded
                    self.infoState = .finished
                }
            } catch {
                self.infoState = .error
                fatalError(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}

//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: String
    @StateObject var viewModel = PokemonInfoViewModel(infoState: .loading)
    
    var body: some View {
        ZStack {
            switch viewModel.infoState {
            case.loading:
                Text("Loading...")
                    .font(.largeTitle)
            case .finished:
                VStack {
                    AsyncImage(url: imageURL()) { imageData in
                        if let image = imageData.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                                .shadow(color: .white, radius: 2.0, x: 1, y: 1)
                                .padding()
                        } else if imageData.error != nil {
                            Image(systemName: "questionmark.diamond")
                                .imageScale(.large)
                        } else {
                            ProgressView()
                        }
                    }
                    Text(self.viewModel.pokemonInfo?.name ?? "")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                    stats()
                }
            case .error:
                Text("Something went wrong")
                    .font(.largeTitle)
            }
        }
        .task {
            await viewModel.fetchPokemonInfo(pokemon)
        }
    }
    
    func stats() -> some View {
        VStack {
            Text("Stats")
                .font(.headline)
            Text("Height: \(self.viewModel.pokemonInfo?.height ?? 0)")
            Text("Weight: \(self.viewModel.pokemonInfo?.weight ?? 0)")
        }
        .frame(alignment: .leading)
    }
    
    func imageURL() -> URL {
        let url = (URL(string: viewModel.pokemonInfo?.sprites.front_default ?? "") ?? URL(string: ""))!
        return url
    }
}

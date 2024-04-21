//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import SwiftUI

struct PokemoneListView: View {
    let pokemon: Pokemon_List
    
    var body: some View {
        NavigationLink(destination: PokemonDetailView(pokemon: pokemon.url)) {
            HStack {
                AsyncImage(url: imageURL()) { imageData in
                    if let image = imageData.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding(.leading, 8)
                    } else if imageData.error != nil {
                        Image(systemName: "questionmark.diamond")
                            .imageScale(.large)
                    } else {
                        ProgressView()
                    }
                }
                Spacer()
                Text(pokemon.name)
                    .font(.headline)
                    .lineLimit(1)                
            }
            .padding(.vertical, 8)
        }
    }
    
    func imageURL() -> URL {
        let pokemonIdentifier = pokemonIdentifier()
        let url = (URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonIdentifier).png") ?? URL(string: ""))!
        return url
    }
    
    func pokemonIdentifier() -> String {
        let identifier = URL(string: pokemon.url)?.lastPathComponent ?? ""
        return identifier
    }
}

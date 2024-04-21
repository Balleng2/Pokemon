//
//  ContentView.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView{
            switch viewModel.appState {
            case .loading:
                Text("Loading...")
            case .pokemon_loaded:
                List {
                    ForEach(viewModel.listOfPokemon) { pokemon in
                        PokemoneListView(pokemon: pokemon)
                    }
                }
                .navigationTitle("Pokedex")
            case .error_loading:
                Text("Something went wrong")
            }
        }
        .task {
            await viewModel.fetchList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

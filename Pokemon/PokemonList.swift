//
//  PokemonList.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import Foundation

struct Pokemon_List: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
}

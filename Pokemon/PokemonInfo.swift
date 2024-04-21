//
//  PokemonInfo.swift
//  Pokemon
//
//  Created by Balleng Balleng on 2024/04/18.
//

import Foundation

struct PokemonInfo: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let base_experience: Int
    let is_default: Bool
//    let species: Species
    let sprites: Sprite
    
    struct Sprite: Codable {
        let front_default: String
    }
}

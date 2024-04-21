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
    let types: [Types]
    let sprites: Sprite
    
    struct Sprite: Codable {
        let front_default: String
    }
}

struct Types: Identifiable, Codable  {
    let id = UUID()
    let slot: Int
    let type: Type_Name
    
    struct Type_Name: Codable {
        let name: String
    }
}

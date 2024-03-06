import UIKit
import PokemonAPI

enum PokemonDetail {
    struct Pokemon {
        let id: Int
        let name: String
        let type: [PKMPokemonType]?
        let specie: String
        var image: String {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        }
        let stats: [PKMPokemonStat]
    }
}

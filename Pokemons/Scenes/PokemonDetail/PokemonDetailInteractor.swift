import UIKit
import PokemonAPI

protocol PokemonDetailBusinessLogic {
    func fetchPokemonDetail()
}

protocol PokemonDetailDataStore {
    var pokemonName: String? { get set }
}

class PokemonDetailInteractor: PokemonDetailBusinessLogic, PokemonDetailDataStore {
    var pokemonName: String?
    // MARK: - Attributes

    var presenter: PokemonDetailPresentationLogic?
    var worker: PokemonAPI

    // MARK: - PokemonDetailDataStore

    init(worker: PokemonAPI = PokemonAPI()) {
        self.worker = worker
    }

    // MARK: - PokemonDetailBusinessLogic
    func fetchPokemonDetail() {
        guard let pokemonName = pokemonName else { return }
        worker.pokemonService.fetchPokemon(pokemonName) { [weak self] result in
            switch result {
            case let .success(pokemon):
                let pokemon = PokemonDetail.Pokemon.init(
                    id: pokemon.id ?? 0,
                    name: pokemon.name ?? "",
                    type: pokemon.types,
                    specie: pokemon.species?.name ?? "",
                    stats: pokemon.stats ?? []
                )
                DispatchQueue.main.async {
                    self?.presenter?.setupInformation(pokeInformation: pokemon)
                }
            case .failure:
                break
            }
        }
    }
}

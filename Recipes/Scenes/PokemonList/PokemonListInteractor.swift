import UIKit
import PokemonAPI

protocol PokemonListBusinessLogic {
    func fetchPokemons()
    func searchPokemon(with text: String)
}

protocol PokemonListDataStore {
    var pokemonsList: [PokemonList.Pokemon]? { get set }
    var selectedPokemonName: String? { get set }
}

class PokemonListInteractor: PokemonListBusinessLogic, PokemonListDataStore {
    var selectedPokemonName: String?
    var pokemonsList: [PokemonList.Pokemon]?
    var originalPokemonsList: [PokemonList.Pokemon]? {
        didSet {
            saveOriginalPokemonsList()
        }
    }
    var presenter: PokemonListPresentationLogic?
    var pokemonsAPI: PokemonAPI

    private let originalPokemonsListKey = "OriginalPokemonsList"

    init(pokemonsAPI: PokemonAPI = PokemonAPI()) {
        self.pokemonsAPI = pokemonsAPI
        loadOriginalPokemonsList()
    }

    // MARK: - PokemonListBusinessLogic
    func fetchPokemons() {
        pokemonsAPI.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 150)) { result in
            switch result {
            case .success(let pagedObject):
                if let pokeResult = pagedObject.results as? [PKMNamedAPIResource] {
                    self.pokemonsList = pokeResult.map { PokemonList.Pokemon(name: $0.name ?? "") }
                    self.originalPokemonsList = self.pokemonsList
                } else {
                    print("Error: Unable to retrieve the list of Pokémon.")
                }
                self.presenter?.reloadTableView()
            case .failure(let error):
                print("Error al recuperar la lista de Pokémon: \(error)")
            }
        }
    }

    func searchPokemon(with text: String) {
        guard let allPokemons = originalPokemonsList else {
            return
        }
        
        if text.isEmpty {
            self.pokemonsList = allPokemons
        } else {
            self.pokemonsList = allPokemons.filter { $0.name.lowercased().contains(text.lowercased()) }
        }
        
        presenter?.reloadTableView()
    }

    // MARK: - UserDefaults Handling
    private func saveOriginalPokemonsList() {
        guard let originalPokemonsList = originalPokemonsList else {
            return
        }
        let encodedData = try? JSONEncoder().encode(originalPokemonsList)
        UserDefaults.standard.set(encodedData, forKey: originalPokemonsListKey)
    }

    private func loadOriginalPokemonsList() {
        if let savedData = UserDefaults.standard.data(forKey: originalPokemonsListKey),
           let decodedList = try? JSONDecoder().decode([PokemonList.Pokemon].self, from: savedData) {
            self.originalPokemonsList = decodedList
        }
    }
}

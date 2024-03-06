import UIKit

@objc protocol PokemonListRoutingLogic {
    func navigateToPokemonDetail()
}

protocol PokemonListDataPassing {
    var dataStore: PokemonListDataStore? { get }
}

class PokemonListRouter: NSObject, PokemonListRoutingLogic, PokemonListDataPassing {

    weak var viewController: PokemonListViewController?
    var dataStore: PokemonListDataStore?
    
    func navigateToPokemonDetail() {
        let pokemonDetailVC = PokemonDetailViewController()
        if var destination = pokemonDetailVC.router?.dataStore {
            passDataToPokemonDetailVC(origin: dataStore, destination: &destination)
        }
        viewController?.navigationController?.navigationBar.tintColor = .black
        viewController?.navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
    func passDataToPokemonDetailVC(
        origin: PokemonListDataStore?,
        destination: inout PokemonDetailDataStore
    ) {
        destination.pokemonName = origin?.selectedPokemonName
    }
}

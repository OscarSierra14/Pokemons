import UIKit

protocol PokemonListPresentationLogic {
    func reloadTableView()
}

class PokemonListPresenter: PokemonListPresentationLogic {

    weak var viewController: PokemonListDisplayLogic?

    // MARK: - PokemonListPresentationLogic
    func reloadTableView() {
        viewController?.reloadTableView()
    }
}

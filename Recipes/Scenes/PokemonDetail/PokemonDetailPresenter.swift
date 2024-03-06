import UIKit

protocol PokemonDetailPresentationLogic {
    func setupInformation(pokeInformation: PokemonDetail.Pokemon)
}

class PokemonDetailPresenter: PokemonDetailPresentationLogic {

    weak var viewController: PokemonDetailDisplayLogic?

    // MARK: - PokemonDetailPresentationLogic
    func setupInformation(pokeInformation: PokemonDetail.Pokemon) {
        viewController?.setupInformation(pokeInformation: pokeInformation)
    }
}

import UIKit

@objc protocol PokemonDetailRoutingLogic {
}

protocol PokemonDetailDataPassing {
    var dataStore: PokemonDetailDataStore? { get }
}

class PokemonDetailRouter: NSObject, PokemonDetailRoutingLogic, PokemonDetailDataPassing {

    weak var viewController: PokemonDetailViewController?
    var dataStore: PokemonDetailDataStore?

}

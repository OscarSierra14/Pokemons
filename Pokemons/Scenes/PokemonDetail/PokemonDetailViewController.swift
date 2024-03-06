import UIKit
import PokemonAPI
import SDWebImage

protocol PokemonDetailDisplayLogic: AnyObject {
    func setupInformation(pokeInformation: PokemonDetail.Pokemon)
}

class PokemonDetailViewController: BaseViewController, PokemonDetailDisplayLogic {

    var interactor: PokemonDetailBusinessLogic?
    var router: (NSObjectProtocol & PokemonDetailRoutingLogic & PokemonDetailDataPassing)?

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let viewController = self
        let interactor = PokemonDetailInteractor()
        let presenter = PokemonDetailPresenter()
        let router = PokemonDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        interactor?.fetchPokemonDetail()
    }

    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundImage)
        view.addSubview(nameLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 16.0),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),

            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0)
        ])
    }

    func setupInformation(pokeInformation: PokemonDetail.Pokemon) {
        self.backgroundImage.sd_setImage(with: URL(string: pokeInformation.image))
        self.title = pokeInformation.name

        let name = createKeyValueStack(withPairs: [(key: "Name: ", value: pokeInformation.name)])
        stackView.addArrangedSubview(name)

        let specie = createKeyValueStack(withPairs: [(key: "Specie: ", value: pokeInformation.specie)])
        stackView.addArrangedSubview(specie)

        let types = createStackView(withTitle: "Types", andItems: pokeInformation.type?.map{$0.type?.name ?? ""} ?? [])
        stackView.addArrangedSubview(types)
        
        let stats = createStackView(withTitle: "Stats", andItems: pokeInformation.stats.map{$0.stat?.name ?? ""})
        stackView.addArrangedSubview(stats)
    }

    private func createStackView(withTitle title: String, andItems items: [String]) -> UIStackView {
        // Crear el stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8  // Espacio entre elementos
        stackView.alignment = .leading
        
        // Crear y agregar la etiqueta del título
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        stackView.addArrangedSubview(titleLabel)
        
        // Agregar etiquetas para cada elemento en la matriz
        for item in items {
            let itemLabel = UILabel()
            itemLabel.text = item
            stackView.addArrangedSubview(itemLabel)
        }
        
        return stackView
    }

    func createKeyValueStack(withPairs pairs: [(key: String, value: String)]) -> UIStackView {
        // Crear el stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8  // Espacio entre elementos
        stackView.alignment = .leading
        
        // Agregar etiquetas para cada par clave-valor
        for pair in pairs {
            let keyLabel = UILabel()
            keyLabel.text = pair.key
            keyLabel.font = UIFont.boldSystemFont(ofSize: 16)
            stackView.addArrangedSubview(keyLabel)
            
            let valueLabel = UILabel()
            valueLabel.text = pair.value
            stackView.addArrangedSubview(valueLabel)
        }
        
        return stackView
    }
}

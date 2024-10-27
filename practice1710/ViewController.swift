import UIKit
import SnapKit
import Combine

enum MenuListControllerOutputMessage {
    case drinkSelected(Drink)
}

final class MenuListViewController: UIViewController {
    
    
    private let _outputPublisher = PassthroughSubject<MenuListControllerOutputMessage, Never>()
    var outputPublisher: AnyPublisher<MenuListControllerOutputMessage, Never> {
        _outputPublisher.eraseToAnyPublisher()
    }

    let drinks: [Drink]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DrinkCell.self, forCellReuseIdentifier: DrinkCell.identifier)
        return tableView
    }()
    
    init(drinks: [Drink]) {
        self.drinks = drinks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension MenuListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinkCell.identifier, for: indexPath) as? DrinkCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: drinks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _outputPublisher.send(.drinkSelected(drinks[indexPath.row]))
    }
    
}


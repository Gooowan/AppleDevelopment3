import UIKit
import SnapKit
import Combine

enum MenuListControllerOutputMessage {
    case studentSelected(Student)
}

final class MenuListViewController: UIViewController {
    
    private let _outputPublisher = PassthroughSubject<MenuListControllerOutputMessage, Never>()
    var outputPublisher: AnyPublisher<MenuListControllerOutputMessage, Never> {
        _outputPublisher.eraseToAnyPublisher()
    }

    let students: Students
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StudentCell.self, forCellReuseIdentifier: StudentCell.identifier)
        return tableView
    }()
    
    init() {
        self.students = Students(filename: "students")
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
        return students.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as? StudentCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: students.list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _outputPublisher.send(.studentSelected(students.list[indexPath.row]))
    }
    
}


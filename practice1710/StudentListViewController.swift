import UIKit
import SnapKit
import Combine

enum StudentListControllerOutputMessage {
    case studentSelected(Student)
}

final class StudentListViewController: UIViewController {
    
    private let _outputPublisher = PassthroughSubject<StudentListControllerOutputMessage, Never>()
    var outputPublisher: AnyPublisher<StudentListControllerOutputMessage, Never> {
        _outputPublisher.eraseToAnyPublisher()
    }

    let students: Students
    
    @objc private func addStudent() {
        let alertController = UIAlertController(title: "Add Student", message: nil, preferredStyle: .alert)
        
        alertController.addTextField {
            $0.placeholder = "Name"
        }
        
        alertController.addTextField {
            $0.placeholder = "Age"
            $0.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let nameField = alertController.textFields?[0]
            let ageField = alertController.textFields?[1]
            
            guard let name = nameField?.text, !name.isEmpty,
                  let ageText = ageField?.text, let age = Int(ageText) else { return }
            
            
            let newStudent = Student(id: self.students.list.count + 1, name: name, age: age, subjects: [], address: nil, scores: nil, hasScholarship: false, graduationYear: nil, imageName: nil)
            
            self.students.list.append(newStudent)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true, completion: nil)

    }


    
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
        
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupLayout()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStudent))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    func setupLayout() {
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}


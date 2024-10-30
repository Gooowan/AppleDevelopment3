import UIKit
import SnapKit

final class StudentsWithSubjectViewController: UIViewController {

    private let subject: String
    private let students: [Student]
    private let tableView = UITableView()

    init(subject: String, allStudents: [Student]) {
        self.subject = subject
        self.students = allStudents.filter { $0.subjects?.contains(subject) == true }
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        view.backgroundColor = .white
        title = "Students in \(subject)"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StudentCell.self, forCellReuseIdentifier: StudentCell.identifier)
        view.addSubview(tableView)
    }

    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension StudentsWithSubjectViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudentCell.identifier, for: indexPath) as? StudentCell else {
            return UITableViewCell()
        }
        cell.setupCell(with: students[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let selectedStudent = students[indexPath.row]
//        let detailVC = StudentDetailViewController(student: selectedStudent)
//        
//        navigationController?.pushViewController(detailVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}

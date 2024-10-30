import Foundation
import UIKit
import Combine

final class Coordinator {
    
    let rootViewController: UINavigationController
    private var cancellables: Set<AnyCancellable> = []
    private let students: [Student]
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        
        let studentsWrapper = Students(filename: "students")
        self.students = studentsWrapper.list
    }
    
    func start() {
        let mainViewController = StudentListViewController()
        
        mainViewController.outputPublisher
            .sink { [weak self] message in
                switch message {
                case let .studentSelected(student):
                    self?.showDetailsViewController(with: student)
                }
            }
            .store(in: &cancellables)
        
        rootViewController.pushViewController(mainViewController, animated: true)
    }

    func showDetailsViewController(with student: Student) {
        let controller = StudentDetailViewController(student: student)
        
        controller.outputPublisher
            .sink { [weak self] message in
                switch message {
                case let .subjectSelected(subject):
                    self?.showStudentsWithSubject(subject)
                }
            }
            .store(in: &cancellables)
        
        rootViewController.pushViewController(controller, animated: true)
    }
    
    func showStudentsWithSubject(_ subject: String) {
        let studentsWithSubjectVC = StudentsWithSubjectViewController(subject: subject, allStudents: students)
        rootViewController.pushViewController(studentsWithSubjectVC, animated: true)
    }
}

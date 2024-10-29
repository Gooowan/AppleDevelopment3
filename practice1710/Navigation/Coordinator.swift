//
//  Coordinator.swift
//  practice1710
//
//  Created by Ivan Solomatin on 24.10.2024.
//

import Foundation
import UIKit
import Combine

final class Coordinator {
    
    let rootViewController: UINavigationController
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let mainViewController = MenuListViewController()
        
        mainViewController.outputPublisher
            .sink { [weak self] message in
                switch message {
                case let .studentSelected(student):
                    self?.showDetailsViewController(with: student)
                }
            }
            .store(in: &cancellable)
        
        rootViewController.pushViewController(mainViewController, animated: true)
    }

    func showDetailsViewController(with student: Student) {
        let controller = ViewDetailsController(student: student)
        rootViewController.pushViewController(controller, animated: true)
    }
}

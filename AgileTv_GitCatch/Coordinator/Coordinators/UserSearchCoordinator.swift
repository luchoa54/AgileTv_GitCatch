//
//  UserSearchCoordinator.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation
import UIKit

class UserSearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    let userSearchViewController : UserSearchViewController = UserSearchViewController()
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.pushViewController(self.userSearchViewController, animated: true)
    }
    
    func popToRootViewController() {
        self.navigationController.popToRootViewController(animated: true)
    }
}

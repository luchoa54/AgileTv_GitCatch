//
//  DetailsUserViewController.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation
import UIKit

class DetailsUserCoordinator: Coordinator {
    var navigationController: UINavigationController
    let user: User
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let detailsVC = DetailsUserViewController(user: user)
        self.navigationController.pushViewController(detailsVC, animated: true)
    }
    
    func popToRootViewController() {
        self.navigationController.popToRootViewController(animated: true)
    }
}


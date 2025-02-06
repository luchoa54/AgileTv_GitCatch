//
//  DetailsUserViewController.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation
import UIKit

class DetailsUserCoordinator:Coordinator {
    var navigationController: UINavigationController
    let detailsUserViewController : DetailsUserViewController = DetailsUserViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.pushViewController(self.detailsUserViewController, animated: true)
    }
    
    func popToRootViewController(){
        self.navigationController.popToRootViewController(animated: true)
    }
}

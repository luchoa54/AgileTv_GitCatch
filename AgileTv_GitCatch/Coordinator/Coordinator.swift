//
//  Coordinator.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController:UINavigationController {get set}
    func start()
    func popToRootViewController()
}

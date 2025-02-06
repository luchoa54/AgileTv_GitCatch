//
//  ViewController.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import UIKit

class UserSearchViewController: UIViewController {

    private lazy var myView: View = {
        return View()
    }()

    override func loadView() {
        super.loadView()

        self.view = myView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.userSearchTitle
        
        myView.setup()

    }
}


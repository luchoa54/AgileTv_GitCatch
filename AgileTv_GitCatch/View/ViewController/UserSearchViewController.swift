//
//  ViewController.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class UserSearchViewController: UIViewController {
    
    private let userSearchViewModel = UserSearchViewModel.shared
    private let disposeBag = DisposeBag()
    private let coordinator: UserSearchCoordinator

    init(coordinator: UserSearchCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var myView: UserSeachView = {
        return UserSeachView()
    }()
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.userSearchTitle
        
        myView.setup()

        myView.button.rx.tap
            .bind { [weak self] in
                guard let self = self, let username = self.myView.textField.text else { return }
                self.searchUser(with: username)
            }
            .disposed(by: disposeBag)

        userSearchViewModel.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .idle:
                    break
                case .loading:
                    self.showLoading(true)
                case .success(let user):
                    self.showLoading(false)
                    self.navigateToUserDetails(user: user)
                case .error(let message):
                    self.showLoading(false)
                    self.showAlert(message: message)
                }
            })
            .disposed(by: disposeBag)
    }

    private func showLoading(_ show: Bool) {
        myView.loadingIndicator.isHidden = !show
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func searchUser(with username: String) {
        userSearchViewModel.searchUser(with: username)
    }
    
    private func navigateToUserDetails(user: User) {
        let detailsCoordinator = DetailsUserCoordinator(navigationController: coordinator.navigationController, user: user)
        detailsCoordinator.start()
    }
}

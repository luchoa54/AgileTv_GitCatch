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
        
        // Binding para o campo de texto (usuário)
        myView.button.rx.tap
            .bind { [weak self] in
                guard let self = self, let username = self.myView.textField.text else { return }
                self.searchUser(with: username)
            }
            .disposed(by: disposeBag)
        
        // Exibir nome do usuário e repositórios
        userSearchViewModel.user
            .map { "Nome do usuário: \($0.name)" }
            .bind(to: myView.userNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        userSearchViewModel.repositories
            .map { repos in
                repos.map { repo in
                    let language = repo.language ?? "Não especificada"
                    return "Repositório: \(repo.name) - Linguagem: \(language)"
                }
                .joined(separator: "\n")
            }
            .bind(to: myView.reposLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // Função para iniciar a busca do usuário
    private func searchUser(with username: String) {
        userSearchViewModel.searchUser(with: username)
    }
}

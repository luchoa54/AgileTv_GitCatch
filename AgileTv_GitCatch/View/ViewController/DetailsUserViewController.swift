//
//  DetailsUserViewController.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsUserViewController: UIViewController {
    
    private let user: User
    private let disposeBag = DisposeBag()
    private let repositories = BehaviorSubject<[RepositoryModel]>(value: [])
    
    private lazy var detailsUserView = DetailsUserView()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailsUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    private func bindData() {
        detailsUserView.userNameLabel.text = user.owner.name
        repositories.onNext(user.repositories)
        
        if let url = URL(string: user.owner.avatar) {
            downloadImage(from: url)
        }
        
        repositories
            .bind(to: detailsUserView.tableView.rx.items(cellIdentifier: "RepositoryCell", cellType: RepositoryCell.self)) { _, repository, cell in
                cell.configure(with: repository)
            }
            .disposed(by: disposeBag)
    }
    
    private func downloadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.detailsUserView.profileImageView.image = image
                }
            }
        }
    }
}



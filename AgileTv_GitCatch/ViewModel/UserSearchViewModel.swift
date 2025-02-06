//
//  UserSearchViewModel.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation
import RxSwift
import RxCocoa

class UserSearchViewModel {
    
    private var userSearchService: UserSearchServiceProtocol
    
    // Variáveis observáveis
    public let user: PublishSubject<UserModel> = PublishSubject()
    public let repositories: PublishSubject<[RepositoryModel]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<Error> = PublishSubject()
    public let disposeBag = DisposeBag()
    
    // Init
    public static let shared = UserSearchViewModel(userSearchService: UserSearchService())
    
    public let state: BehaviorSubject<ViewModelState<[UserModel]>> = BehaviorSubject(value: .idle)
    
    init(userSearchService: UserSearchServiceProtocol) {
        self.userSearchService = userSearchService
    }
    
    func searchUser(with username: String) {
        self.loading.onNext(true)
        
        self.userSearchService.searchUser(username: username, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let user):
                        self.user.onNext(user.owner)
                        self.repositories.onNext(user.repositories)
                    case .failure(let error):
                        self.error.onNext(error)
                }
                self.loading.onNext(false)
            }
        })
    }
}


//
//  UserSearchViewModel.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import RxSwift
import RxCocoa

class UserSearchViewModel {
    
    private let userSearchService: UserSearchServiceProtocol
    private let disposeBag = DisposeBag()
    
    let user = PublishSubject<User>()
    let repositories = PublishSubject<[RepositoryModel]>()
    let errorMessage = PublishSubject<String>()

    public static let shared = UserSearchViewModel(userSearchService: UserSearchService())
    
    public let state: BehaviorSubject<ViewModelState<User>> = BehaviorSubject(value: .idle)
    
    init(userSearchService: UserSearchServiceProtocol) {
        self.userSearchService = userSearchService
    }
    
    func searchUser(with username: String) {
        state.onNext(.loading)
        
        userSearchService.searchUser(username: username) { [weak self] result in
            switch result {
            case .success(let user):
                self?.state.onNext(.success(user))
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        let errorMessage: String
        if error is URLError {
            errorMessage = "A network error has occurred. Check your Internet connection and try again later."
        } else if error is DecodingError {
            errorMessage = "User not found. Please enter another name."
        } else {
            errorMessage = error.localizedDescription
        }
        state.onNext(.error(errorMessage))
    }
}



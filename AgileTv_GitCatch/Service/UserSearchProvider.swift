//
//  UserSearchService.swift
//  AgileTv_GitCatch
//
//  Created by Luciano Uchoa on 05/02/25.
//

import Foundation

protocol UserSearchServiceProtocol {
    func searchUser(username: String, completion: @escaping(Result<User, Error>) -> Void)
}

class UserSearchService: UserSearchServiceProtocol {
    
    // Função para buscar o usuário e seus repositórios
    func searchUser(username: String, completion: @escaping(Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                // Primeiro, buscamos os repositórios
                var repositories = try JSONDecoder().decode([RepositoryModel].self, from: data)
                
                // Agora, buscamos as informações do usuário (nome e avatar)
                let userURL = URL(string: "https://api.github.com/users/\(username)")!
                let userTask = URLSession.shared.dataTask(with: userURL) { (userData, _, userError) in
                    if let userError = userError {
                        completion(.failure(userError))
                        return
                    }
                    
                    guard let userData = userData else { return }
                    
                    do {
                        // Decodificando o usuário com nome e avatar
                        let userModel = try JSONDecoder().decode(UserModel.self, from: userData)
                        
                        // Agora buscamos as linguagens para cada repositório
                        let group = DispatchGroup()
                        
                        for index in repositories.indices {
                            group.enter()
                            self.fetchLanguages(for: repositories[index]) { language in
                                repositories[index] = RepositoryModel(
                                    name: repositories[index].name,
                                    languagesURL: repositories[index].languagesURL,
                                    language: language
                                )
                                group.leave()
                            }
                        }
                        
                        // Quando todas as linguagens forem obtidas
                        group.notify(queue: .main) {
                            // Agora retornamos tanto o usuário quanto os repositórios
                            let user = User(owner: userModel, repositories: repositories)
                            completion(.success(user))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                }
                userTask.resume()
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // Método auxiliar para buscar as linguagens dos repositórios
    private func fetchLanguages(for repository: RepositoryModel, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: repository.languagesURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Erro ao buscar linguagens: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let languages = try? JSONDecoder().decode([String: Int].self, from: data) else {
                completion(nil)
                return
            }
            
            let mostUsedLanguage = languages.max { $0.value < $1.value }?.key
            completion(mostUsedLanguage)
        }
        task.resume()
    }
}


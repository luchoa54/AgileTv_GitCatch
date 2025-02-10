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
    
    func searchUser(username: String, completion: @escaping(Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Verificando o status code
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 403 {
                // Caso o rate limit tenha sido atingido
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = json["message"] as? String, message.contains("rate limit exceeded") {
                    completion(.failure(RateLimitExceededError()))
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                var repositories = try JSONDecoder().decode([RepositoryModel].self, from: data)
                
                let userURL = URL(string: "https://api.github.com/users/\(username)")!
                let userTask = URLSession.shared.dataTask(with: userURL) { (userData, _, userError) in
                    if let userError = userError {
                        completion(.failure(userError))
                        return
                    }
                    
                    guard let userData = userData else { return }
                    
                    do {
                        let userModel = try JSONDecoder().decode(UserModel.self, from: userData)
                        
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
                        
                        group.notify(queue: .main) {
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

struct RateLimitExceededError: Error {
    var localizedDescription: String {
        return "You have exceeded the rate limit for API requests. Please try again later."
    }
}




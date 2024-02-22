//
//  RepositoryService.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 19.02.2024.
//

import Foundation

class RepositoryService {
    func fetchRepositories(completion: @escaping (Result<[Repository], Error>) -> Void) {
        let organizations = ["algorand", "perawallet", "algorandfoundation"]
        var allRepositories: [Repository] = []
        let dispatchGroup = DispatchGroup()
        
        for organization in organizations {
            dispatchGroup.enter()
            let apiUrl = "https://api.github.com/orgs/\(organization)/repos"
            
            URLSession.shared.dataTask(with: URL(string: apiUrl)!) { data, _, error in
                defer { dispatchGroup.leave() }
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let repositories = try JSONDecoder().decode([Repository].self, from: data)
                        allRepositories.append(contentsOf: repositories)
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(allRepositories))
        }
    }
}

//
//  FavoriteRepositoryManager.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 21.02.2024.
//

import Foundation

class FavoriteRepositoryManager {
    static let shared = FavoriteRepositoryManager()
    
    private let userDefaults = UserDefaults.standard
    private let favoriteRepositoriesKey = "FavoriteRepositories"
    
    func getFavoriteRepositories() -> [Repository] {
        guard let data = userDefaults.data(forKey: favoriteRepositoriesKey) else { return [] }
        do {
            let repositories = try JSONDecoder().decode([Repository].self, from: data)
            return repositories
        } catch {
            print("Error decoding favorite repositories: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveFavoriteRepositories(_ repositories: [Repository]) {
        do {
            let data = try JSONEncoder().encode(repositories)
            userDefaults.set(data, forKey: favoriteRepositoriesKey)
        } catch {
            print("Error encoding favorite repositories: \(error.localizedDescription)")
        }
    }
}


//
//  RepositoryListViewModel.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 19.02.2024.
//

import Foundation

enum FilterOption {
    case name
    case organization
}

@MainActor
class RepositoryViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var favoriteRepositories: [Repository] = FavoriteRepositoryManager.shared.getFavoriteRepositories()
    @Published var filteredRepositories: [Repository] = []
    private let repositoryService: RepositoryService
    @Published var searchText: String = ""
    @Published var filterOption: FilterOption = .name
    
    
    
    init(repositoryService: RepositoryService = RepositoryService()) {
        self.repositoryService = repositoryService
    }
    
    var isSearching: Bool {
            !searchText.isEmpty
        }
    
    func fetchRepositories() {
        repositoryService.fetchRepositories { result in
            switch result {
            case .success(let repositories):
                DispatchQueue.main.async {
                    self.repositories = repositories.sorted { $0.name < $1.name }
                }
            case .failure(let error):
                print("Error fetching repositories: \(error)")
            }
        }
    }
    

    
    func filterRepositories(searchText: String) {
        guard !searchText.isEmpty else {
                    filteredRepositories = []
                    return
                }
        let search = searchText.lowercased()
        switch filterOption {
                case .name:
                    filteredRepositories = repositories.filter { repo in
                        let name = repo.name.lowercased()
                        return name.contains(search)
                    }
                case .organization:
                    filteredRepositories = repositories.filter { repo in
                        let organization = repo.owner.login.lowercased()
                        return organization == search
                    }
                }
        }
    
    func addFavorite(repository: Repository) {
           favoriteRepositories.append(repository)
           FavoriteRepositoryManager.shared.saveFavoriteRepositories(favoriteRepositories)
       }
       
       func removeFavorite(repository: Repository) {
           if let index = favoriteRepositories.firstIndex(where: { $0.id == repository.id }) {
               favoriteRepositories.remove(at: index)
               FavoriteRepositoryManager.shared.saveFavoriteRepositories(favoriteRepositories)
           }
       }
}

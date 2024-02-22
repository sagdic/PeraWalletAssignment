//
//  FavoritesView.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 22.02.2024.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: RepositoryViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteRepositories) { repo in
                NavigationLink(destination: RepositoryDetailView(repository: repo)) {
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .font(.headline)
                        Text(repo.description ?? "Empty Description")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
        
    }
}

//
//  ContentView.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 15.02.2024.
//

import SwiftUI

struct RepositoryView: View {
    @StateObject var viewModel = RepositoryViewModel()
    @State private var showingFavorites = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    SearchBar(text: $viewModel.searchText)
                    Picker("Filter by", selection: $viewModel.filterOption) {
                        Text("Name").tag(FilterOption.name)
                        Text("Organization").tag(FilterOption.organization)
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
                List(viewModel.isSearching ? viewModel.filteredRepositories : viewModel.repositories) { repo in
                    NavigationLink(destination: RepositoryDetailView(repository: repo)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(repo.name)
                                    .font(.headline)
                                Text(repo.description ?? "Empty Description")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Button(action: {
                                if viewModel.favoriteRepositories.contains(where: { $0.id == repo.id }) {
                                    viewModel.removeFavorite(repository: repo)
                                } else {
                                    viewModel.addFavorite(repository: repo)
                                }
                            }) {
                                Image(systemName: viewModel.favoriteRepositories.contains(where: { $0.id == repo.id }) ? "star.fill" : "star")
                                    .foregroundColor(viewModel.favoriteRepositories.contains(where: { $0.id == repo.id }) ? .yellow : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .navigationTitle("Repositories")
                .navigationBarItems(trailing:
                    Button(action: {
                        showingFavorites.toggle()
                    }) {
                        Image(systemName: "star.fill")
                            .foregroundColor(showingFavorites ? .yellow : .gray)
                    }
                )
            }
            .onChange(of: viewModel.searchText) { newValue in
                viewModel.filterRepositories(searchText: newValue)
            }
            .onChange(of: viewModel.filterOption) {newValue in
                viewModel.searchText = ""
            }
            .onAppear {
                viewModel.fetchRepositories()
            }
            .sheet(isPresented: $showingFavorites) {
                FavoritesView(viewModel: viewModel)
            }
        }
    }
}



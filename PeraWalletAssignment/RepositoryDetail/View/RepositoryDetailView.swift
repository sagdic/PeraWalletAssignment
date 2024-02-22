//
//  RepositoryDetailView.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 19.02.2024.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            if let image = imageLoader.image {
                           Image(uiImage: image)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(width: 100, height: 100)
                       } else {
                           ProgressView()
                       }
            Text(repository.owner.login).font(.largeTitle)
            Text(repository.name)
                .font(.title)
            Text(repository.description ?? "Empty Description")
                .font(.body)
            Link("Show on Github", destination: repository.owner.html_url)
        }.padding(.horizontal,8)
        .onAppear {
                    imageLoader.loadImage(from: repository.owner.avatar_url)
                }
    }
}

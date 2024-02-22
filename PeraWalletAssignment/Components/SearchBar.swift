//
//  SearchBar.swift
//  PeraWalletAssignment
//
//  Created by Tayfun Sagdic on 21.02.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

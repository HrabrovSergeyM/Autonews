//
//  NewsfeedListView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListView: View {
    @StateObject private var viewModel = NewsfeedListViewModel()
    
    var body: some View {
        PageListView(pageListVM: viewModel) { item in
            VStack(alignment: .leading) {
                Text(item.title ?? "")
                    .font(.headline)
                Text(item.description ?? "")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
        }
    }
}

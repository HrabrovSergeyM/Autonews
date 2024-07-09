//
//  NewsfeedListView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListView: View {
    
    @StateObject private var vm = NewsfeedListViewModel()
    
    var body: some View {
        PageListView(pageListVM: vm) { item in
            VStack(alignment: .leading) {
                Text(item.title ?? "")
                    .font(.headline)
                Text(item.description ?? "")
                    .font(.subheadline)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
            .shadow(radius: 4)
        }
    }
}

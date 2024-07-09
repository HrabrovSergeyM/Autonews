//
//  NewsfeedListItemView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListItemView: View {
    
    @ObservedObject var vm: NewsfeedListItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: URL(string: vm.titleImageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
            } placeholder: {
                ProgressView()
                    .frame(width: 120, height: 120)
            }
            .frame(alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.title)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(vm.description)
                    .frame(maxWidth: .infinity)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.vertical, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color.white)
        .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
        .shadow(radius: 4)
    }
}

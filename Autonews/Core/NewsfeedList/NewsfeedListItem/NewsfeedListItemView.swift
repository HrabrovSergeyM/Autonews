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
            if let imageData = vm.imageLoader.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
            } else {
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
                .onAppear {
                    vm.loadImage()
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(vm.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
        .shadow(radius: 4)
    }
}

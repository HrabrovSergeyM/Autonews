//
//  NewsfeedListItemView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListItemView: View {
    
    @ObservedObject var vm: NewsfeedListItemViewModel
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                if let imageData = vm.imageLoader.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: Constants.Constraints.newsfeedCardImageWidth,
                            height: Constants.Constraints.newsfeedCardImageHeight
                        )
                        .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
                } else {
                    AsyncImage(url: URL(string: vm.titleImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: Constants.Constraints.newsfeedCardImageWidth,
                                height: Constants.Constraints.newsfeedCardImageHeight
                            )
                            .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
                    } placeholder: {
                        ProgressView()
                            .frame(
                                width: Constants.Constraints.newsfeedCardImageWidth,
                                height: Constants.Constraints.newsfeedCardImageHeight
                            )
                    }
                    .onAppear {
                        vm.loadImage()
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(vm.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(isExpanded ? nil : 2)
                    Text(vm.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(isExpanded ? nil : 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    TagView(tag: vm.categoryType)
                    Text(vm.fullUrl)
                        .foregroundColor(.blue)
                        .font(.callout)
                        .lineLimit(nil)
                        .onTapGesture {
                            guard let url = URL(string: vm.fullUrl) else { return }
                            UIApplication.shared.open(url)
                        }
                    
                    if let formattedDate = vm.publishedDate.toDisplayFormat() {
                        Text(formattedDate)
                            .foregroundColor(.primary)
                            .font(.caption)
                    }
                }
                .opacity(isExpanded ? 1 : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.move(edge: .bottom))
            }
            
        }
        .padding(12)
        .background(Color("feed-item"))
        .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
        .onTapGesture {
            withAnimation(.spring()) {
                isExpanded.toggle()
            }
        }
    }
}

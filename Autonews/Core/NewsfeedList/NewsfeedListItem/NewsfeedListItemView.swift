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
    var onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: isExpanded ? .top : .center, spacing: 12) {
                if let imageData = vm.imageLoader.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: isExpanded ? Constants.Constraints.newsfeedCardImageWidth : 80,
                            height: isExpanded ? Constants.Constraints.newsfeedCardImageHeight : 80
                        )
                        .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
                } else {
                    AsyncImage(url: URL(string: vm.titleImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: isExpanded ? Constants.Constraints.newsfeedCardImageWidth : 80,
                                height: isExpanded ? Constants.Constraints.newsfeedCardImageHeight : 80
                            )
                            .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
                    } placeholder: {
                        ProgressView()
                            .frame(
                                width: 80,
                                height: 80
                            )
                    }
                    .onAppear {
                        vm.loadImage()
                    }
                }
                if !isExpanded {
                    Text(vm.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Text(vm.title)
                        .font(.title2)
                        .foregroundColor(.primary)
                    Text(vm.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
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
            DispatchQueue.main.async {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
                onTap()
            }
        }
    }
}

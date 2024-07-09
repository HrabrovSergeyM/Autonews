//
//  NewsfeedListItemViewModel.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI
import Foundation

final class NewsfeedListItemViewModel: ObservableObject {
    
    @Published var id: Int
    @Published var title: String
    @Published var description: String
    @Published var publishedDate: String
    @Published var url: String
    @Published var fullUrl: String
    @Published var titleImageUrl: String
    @Published var categoryType: String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(newsfeedItem: NewsfeedItemModel) {
        self.id = newsfeedItem.id
        self.title = newsfeedItem.title ?? ""
        self.description = newsfeedItem.description ?? ""
        self.publishedDate = newsfeedItem.publishedDate ?? ""
        self.url = newsfeedItem.url ?? ""
        self.fullUrl = newsfeedItem.fullUrl ?? ""
        self.titleImageUrl = newsfeedItem.titleImageUrl ?? "https://play-lh.googleusercontent.com/HCpTziExtoKvbP0m8qqLmNmZLQ8TqVj4Rwj__-bGErxGahd6Vm1tZcBShHAPzAwQIg"
        self.categoryType = newsfeedItem.categoryType ?? ""
        
        loadImage()
        
    }
    
    func loadImage() {
        imageLoader.loadImage(from: titleImageUrl, imageName: "\(id)", folderName: "feed_item_images")
    }
    
    func update(with newsfeedItem: NewsfeedItemModel) {
        self.id = newsfeedItem.id
        self.title = newsfeedItem.title ?? ""
        self.description = newsfeedItem.description ?? ""
        self.publishedDate = newsfeedItem.publishedDate ?? ""
        self.url = newsfeedItem.url ?? ""
        self.fullUrl = newsfeedItem.fullUrl ?? ""
        self.titleImageUrl = newsfeedItem.titleImageUrl ?? "https://play-lh.googleusercontent.com/HCpTziExtoKvbP0m8qqLmNmZLQ8TqVj4Rwj__-bGErxGahd6Vm1tZcBShHAPzAwQIg"
        self.categoryType = newsfeedItem.categoryType ?? ""
    }
}

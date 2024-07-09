//
//  NewsfeedItemModel.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation

struct NewsfeedItemModel: FeedItem, Decodable {
    let id: Int
    let title: String?
    let description: String?
    let publishedDate: String?
    let url: String?
    let fullUrl: String?
    let titleImageUrl: String?
    let categoryType: String?
}

protocol FeedItem: Identifiable, Decodable {}

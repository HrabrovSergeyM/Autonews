//
//  NewsfeedListModel.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation

struct NewsfeedListModel: FeedList, Decodable {
    var news: [NewsfeedItemModel]
    var totalCount: Int
}

protocol FeedList {
    associatedtype Item: FeedItem
    
    var news: [Item] { get }
    var totalCount: Int { get }
}

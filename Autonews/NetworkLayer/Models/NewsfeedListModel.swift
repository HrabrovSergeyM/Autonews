//
//  NewsfeedListModel.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation

struct NewsfeedListModel: Decodable {
    var news: [NewsfeedItemModel]
    var totalCount: Int
}

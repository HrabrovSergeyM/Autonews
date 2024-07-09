//
//  NewsfeedListViewModel.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import Foundation
import Combine

final class NewsfeedListViewModel: PageListViewModel<NewsfeedItemModel, NewsfeedListModel> {
    private let newsfeedService: NewsfeedServiceProtocol
    
    var onUpdate: (() -> Void)?
    
    init(newsfeedService: NewsfeedServiceProtocol = NewsfeedService()) {
        self.newsfeedService = newsfeedService
        super.init()
        getData(refresh: true)
    }
    
    override func fetchPage(page: Int, size: Int) -> AnyPublisher<NewsfeedListModel, Error> {
        onUpdate?()
        return newsfeedService.fetchNews(page: page, size: size)
    }
}

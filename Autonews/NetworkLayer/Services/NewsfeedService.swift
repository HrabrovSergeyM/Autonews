//
//  NewsfeedService.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation
import Combine

protocol NewsfeedServiceProtocol {
    func fetchNews(limit: Int, offset: Int) -> AnyPublisher<NewsfeedItemModel, Error>
}

final class NewsfeedService: NewsfeedServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchNews(limit: Int, offset: Int) -> AnyPublisher<NewsfeedItemModel, Error> {
        return apiService.fetch(path: .mainLink, parameters: [.limit(limit), .offset(offset)])
    }
}

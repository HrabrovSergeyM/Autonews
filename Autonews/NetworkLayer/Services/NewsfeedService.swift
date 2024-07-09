//
//  NewsfeedService.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import Foundation
import Combine

protocol NewsfeedServiceProtocol {
    func fetchNews(page: Int, size: Int) -> AnyPublisher<NewsfeedListModel, Error>
}

final class NewsfeedService: NewsfeedServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchNews(page: Int, size: Int) -> AnyPublisher<NewsfeedListModel, Error> {
        return apiService.fetch(path: .mainLink(page, size), parameters: [])
    }
}

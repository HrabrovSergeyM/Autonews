//
//  PageListViewModel.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import Foundation
import Combine
import SwiftUI

protocol PageListViewModelProtocol: ObservableObject {
    associatedtype Item: FeedItem
    
    var items: [Item]? { get set }
    var isLoading: Bool { get set }
    var page: Int { get set }
    var size: Int { get set }
    var canLoadMorePages: Bool { get set }
    var totalPages: Int { get }
    
    func getData(refresh: Bool)
    func loadNextPage()
}

class PageListViewModel<Item: FeedItem, List: FeedList>: PageListViewModelProtocol where List.Item == Item {
    @Published var items: [Item]? = nil
    @Published var isLoading: Bool = false
    var size: Int = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10
    var page: Int = 1
    var canLoadMorePages: Bool = true
    private var totalCount: Int = 0
    private var isThrottling: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var totalPages: Int {
        return (totalCount + size - 1) / size
    }
    
    func getData(refresh: Bool = false) {
        if refresh {
            canLoadMorePages = true
            items = nil
        }
        
        guard !isLoading else { return }
        isLoading = true
        
        fetchPage(page: page, size: size)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.isLoading = false
                    print("Error receiving data: \(error.localizedDescription)")
                    print("Full error details: \(error)")
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { response in
                self.isLoading = false
                self.totalCount = response.totalCount
                if refresh {
                    self.items = response.news
                } else {
                    self.items?.append(contentsOf: response.news)
                }
                self.canLoadMorePages = self.page * self.size < self.totalCount
                self.isThrottling = false
            })
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        guard canLoadMorePages, !isLoading, !isThrottling else { return }
        isThrottling = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.page += 1
            self.getData()
        }
    }
    
    func fetchPage(page: Int, size: Int) -> AnyPublisher<List, Error> {
        fatalError("This method must be overridden")
    }
}


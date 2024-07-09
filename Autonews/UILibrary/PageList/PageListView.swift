//
//  PageListView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct PageListView<ViewModel, ItemView>: View where ViewModel: PageListViewModelProtocol, ItemView: View {
    
    @StateObject var pageListVM: ViewModel
    let itemViewBuilder: (ViewModel.Item) -> ItemView
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    if let items = pageListVM.items {
                        ForEach(items, id: \.id) { item in
                            itemViewBuilder(item)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                        }
                    } else {
                        ForEach(0..<8, id: \.self) { _ in
                            ShimmerView(height: Constants.Constraints.newsfeedCardHeight)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
            
            if pageListVM.totalPages > 1 {
                PaginationView(page: $pageListVM.page, totalPages: pageListVM.totalPages, loadPage: {
                    pageListVM.getData(refresh: true)
                })
                .disabled(pageListVM.isLoading)
                .opacity(pageListVM.isLoading ? 0.7 : 1)
                .padding(8)
            }
        }
        .background(Color("feed-list"))
        .onAppear {
            if pageListVM.items == nil {
                pageListVM.getData(refresh: true)
            }
        }
        .refreshable {
            pageListVM.getData(refresh: true)
        }
        .onNetworkChange(isDataAvailable: {
            pageListVM.items != nil
        }, fetchData: {
            pageListVM.getData(refresh: true)
        })
    }
}

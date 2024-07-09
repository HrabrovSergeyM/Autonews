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
                        ForEach(items.indices, id: \.self) { index in
                            itemViewBuilder(items[index])
                        }
                    } else {
                        ForEach(0..<5, id: \.self) { _ in
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                }
            }
            
            if pageListVM.totalPages > 1 {
                PaginationView(page: $pageListVM.page, totalPages: pageListVM.totalPages, loadPage: {
                    pageListVM.getData(refresh: true)
                })
                .disabled(pageListVM.isLoading)
                .padding()
            }
        }
        .onAppear {
            if pageListVM.items == nil {
                pageListVM.getData(refresh: true)
            }
        }
        .refreshable {
            pageListVM.getData(refresh: true)
        }
    }
}

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
                HStack {
                    if pageListVM.page > 1 {
                        Button(action: {
                            pageListVM.page -= 1
                            pageListVM.getData(refresh: true)
                        }) {
                            Text("Previous")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                    ForEach(max(0, pageListVM.page - 3)..<min(pageListVM.totalPages, pageListVM.page + 2), id: \.self) { page in
                        Button(action: {
                            pageListVM.page = page + 1
                            pageListVM.getData(refresh: true)
                        }) {
                            Text("\(page + 1)")
                                .padding()
                                .background(pageListVM.page == page + 1 ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    
                    if pageListVM.page < pageListVM.totalPages {
                        Button(action: {
                            pageListVM.page += 1
                            pageListVM.getData(refresh: true)
                        }) {
                            Text("Next")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
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


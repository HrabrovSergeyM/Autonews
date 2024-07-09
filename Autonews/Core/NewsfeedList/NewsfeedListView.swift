//
//  NewsfeedListView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListView: View {
    
    @StateObject private var vm = NewsfeedListViewModel()
    @State var cacheSize = LocalFileManager.instance.getCacheSize(folderName: "feed_item_images")
    
    var body: some View {
        PageListView(pageListVM: vm) { item in
            NewsfeedListItemView(vm: NewsfeedListItemViewModel(newsfeedItem: item))
        }
        .navigationTitle("News feed")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Text("Cache size: \(cacheSize) mb")
                    Button(action: {
                        LocalFileManager.instance.clearCache(folderName: "feed_item_images")
                    }, label: {
                        Text("Clear cache")
                    })
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .onAppear {
            vm.onUpdate = {
                cacheSize = LocalFileManager.instance.getCacheSize(folderName: "feed_item_images")
            }
        }
    }
}

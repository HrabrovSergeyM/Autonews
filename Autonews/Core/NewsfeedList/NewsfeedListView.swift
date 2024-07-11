//
//  NewsfeedListView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListView: View {
    
    @StateObject private var vm = NewsfeedListViewModel()
    @State var cacheSize = LocalFileManager.instance.getCacheSize(folderName: Constants.FolderName.feedItemImagesFolder)
    
    var body: some View {
        PageListView(pageListVM: vm) { item, onTap in
            NewsfeedListItemView(vm: NewsfeedListItemViewModel(newsfeedItem: item), onTap: onTap)
        }
        .navigationTitle(Constants.Strings.feedNavigationTitle)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Text("Cache size: \(cacheSize) mb")
                    Button(action: {
                        LocalFileManager.instance.clearCache(folderName: Constants.FolderName.feedItemImagesFolder)
                    }, label: {
                        Text(Constants.Strings.clearCache)
                    })
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .onAppear {
            vm.onUpdate = {
                cacheSize = LocalFileManager.instance.getCacheSize(folderName: Constants.FolderName.feedItemImagesFolder)
            }
        }
    }
}

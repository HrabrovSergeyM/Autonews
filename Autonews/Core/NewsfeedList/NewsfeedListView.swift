//
//  NewsfeedListView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct NewsfeedListView: View {
    
    @StateObject private var vm = NewsfeedListViewModel()
    
    var body: some View {
        PageListView(pageListVM: vm) { item in
            NewsfeedListItemView(vm: NewsfeedListItemViewModel(newsfeedItem: item))
        }
    }
}

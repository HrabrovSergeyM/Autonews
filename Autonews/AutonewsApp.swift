//
//  AutonewsApp.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 08.07.2024.
//

import SwiftUI

@main
struct AutonewsApp: App {
    
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NewsfeedListView()
                    .environmentObject(networkMonitor)
            }
        }
    }
}

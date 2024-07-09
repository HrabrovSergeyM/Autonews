//
//  OnNetworkChangeModifier.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct OnNetworkChangeModifier: ViewModifier {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    let isDataAvailable: () -> Bool
    let fetchData: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: networkMonitor.isConnected) { isConnected in
                if isConnected && !isDataAvailable() {
                    fetchData()
                }
            }
    }
}

extension View {
    func onNetworkChange(isDataAvailable: @escaping () -> Bool, fetchData: @escaping () -> Void) -> some View {
        self.modifier(OnNetworkChangeModifier(isDataAvailable: isDataAvailable, fetchData: fetchData))
    }
}

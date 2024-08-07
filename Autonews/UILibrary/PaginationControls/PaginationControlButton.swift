//
//  PaginationControlButton.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct PaginationControlButton: View {
    
    let action: () -> Void
    let icon: String
    
    var body: some View {
        Button(action: {
            withAnimation(.bouncy) {
                action()
            }
        }) {
            Image(systemName: icon)
                .padding(Constants.Constraints.buttonPadding)
                .background(Color("feed-item"))
                .foregroundColor(.primary)
                .cornerRadius(Constants.Constraints.buttonCornerRadius)
        }
    }
}

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
            action()
        }) {
            Image(systemName: icon)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(Constants.Constraints.buttonCornerRadius)
        }
    }
}

//
//  PaginationButton.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct PaginationButton: View {
    
    let action: () -> Void
    var buttonLabel: String
    var isSelected: Bool
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(buttonLabel)
                .padding()
                .background(isSelected ? Color.blue : Color("feed-item"))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(Constants.Constraints.buttonCornerRadius)
        }
    }
}

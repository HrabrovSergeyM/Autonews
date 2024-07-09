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
                .padding(Constants.Constraints.buttonPadding)
                .background(isSelected ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(Constants.Constraints.buttonCornerRadius)
        }
    }
}

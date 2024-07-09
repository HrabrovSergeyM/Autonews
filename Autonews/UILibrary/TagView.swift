//
//  TagView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct TagView: View {
    let tag: String
    
    var body: some View {
        Text(tag)
            .font(.callout)
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    TagView(tag: "Автомобильные новости")
}

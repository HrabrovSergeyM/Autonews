//
//  ShimmerView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct ShimmerView: View {
    
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                RoundedRectangle(cornerRadius: Constants.Constraints.newsfeedCardCornerRadius)
                    .frame(
                        width: Constants.Constraints.newsfeedCardImageWidth,
                        height: Constants.Constraints.newsfeedCardImageHeight - 12
                    )
                    .foregroundColor(Color("feed-list"))
                
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(0...3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(height: 20)
                            .foregroundColor(Color("feed-list"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            }
        }
        .padding(12)
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(Color("feed-item"))
        .cornerRadius(Constants.Constraints.newsfeedCardCornerRadius)
    }
}

//
//  PaginationView.swift
//  Autonews
//
//  Created by Sergey Hrabrov on 09.07.2024.
//

import SwiftUI

struct PaginationView: View {
    
    @Binding var page: Int
    let totalPages: Int
    let loadPage: () -> Void
    
    var body: some View {
        HStack {
            if page > 1 {
                PaginationControlButton(action: {
                    page -= 1
                    loadPage()
                }, icon: "chevron.left")
            }
            
            ForEach(max(0, page - 3)..<min(totalPages, page + 2), id: \.self) { pageIndex in
                PaginationButton(action: {
                    page = pageIndex + 1
                    loadPage()
                }, buttonLabel: "\(pageIndex + 1)", isSelected: page == pageIndex + 1)
            }
            
            if page < totalPages {
                PaginationControlButton(action: {
                    page += 1
                    loadPage()
                }, icon: "chevron.right")
            }
        }
    }
}

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
        HStack(spacing: 8) {
            
            if page > 2 {
                PaginationControlButton(action: {
                    page = 1
                    loadPage()
                }, icon: "chevron.backward.2")
            }
            
            if page > 1 {
                PaginationControlButton(action: {
                    page -= 1
                    loadPage()
                }, icon: "chevron.backward")
            }
            
            ForEach(max(0, page - 2)..<min(totalPages, page + 1), id: \.self) { pageIndex in
                PaginationButton(action: {
                    page = pageIndex + 1
                    loadPage()
                }, buttonLabel: "\(pageIndex + 1)", isSelected: page == pageIndex + 1)
                .disabled(page == pageIndex + 1)
            }
            
            if page < totalPages {
                PaginationControlButton(action: {
                    page += 1
                    loadPage()
                }, icon: "chevron.forward")
            }
            
            if page + 1 < totalPages {
                PaginationControlButton(action: {
                    page = totalPages
                    loadPage()
                }, icon: "chevron.forward.2")
            }
        }
        .frame(maxWidth: .infinity)
    }
}

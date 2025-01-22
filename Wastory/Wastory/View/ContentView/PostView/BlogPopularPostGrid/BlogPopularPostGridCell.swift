//
//  BlogPopularPostGridCell.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct BlogPopularPostGridCell: View {
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.postViewModel) var viewModel
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                Color.clear
                    .onAppear() {
                        viewModel.setBlogPopularPostGridCellWidth(geometry.size.width)
                    }
            }
            .frame(height: 0)
            
            Image(systemName: "questionmark.text.page.fill")
                .resizable()
                .scaledToFill()
                .frame(width: viewModel.getBlogPopularPostGridCellWidth() ,height: viewModel.getBlogPopularPostGridCellWidth() * 5 / 8)
                .clipped()
                .foregroundStyle(Color.unreadNotification)
            
            Spacer()
                .frame(height: 10)
            
            Text("제목제목제목제목제목제목제목제목제목목")
                .font(.system(size: 18, weight: .light))
                .foregroundStyle(Color.primaryLabelColor)
                .lineLimit(2)
        } //VStack
        .padding(.vertical, 10)
        
        .background(Color.white)
        .overlay {
            contentViewModel.navigateToPostViewButton(tempPost())
        }
    }
}


//
//  BlogPopularPostGridCell.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct BlogPopularPostGridCell: View {
    let post: Post
    
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.postViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geometry in
                Color.clear
                    .onAppear() {
                        viewModel.setBlogPopularPostGridCellWidth(geometry.size.width)
                    }
            }
            .frame(height: 0)
            
            KFImageWithDefault(imageURL: post.mainImageURL)
                .scaledToFill()
                .frame(width: viewModel.getBlogPopularPostGridCellWidth() ,height: viewModel.getBlogPopularPostGridCellWidth() * 5 / 8)
                .clipped()
                .foregroundStyle(Color.unreadNotification)
            
            Spacer()
                .frame(height: 10)
            
            Text(post.title)
                .font(.system(size: 18, weight: .light))
                .foregroundStyle(Color.primaryLabelColor)
                .lineLimit(2)
            
            Spacer()
        } //VStack
        .padding(.vertical, 10)
        
        .background(Color.white)
        .overlay {
            contentViewModel.navigateToPostViewButton(post.id, viewModel.blog.id)
        }
    }
}


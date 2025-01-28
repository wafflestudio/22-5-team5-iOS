//
//  CategoryPostListView.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct CategoryPostListView: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.postViewModel) var viewModel
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            
            HStack(alignment: .center, spacing: 6) {
                Text(viewModel.post.categoryID == 0 ? "이 블로그" : viewModel.categoryName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.loadingCoralRed)
                    .lineLimit(1)
                
                Text("의 다른 글") // selected category로 설정
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                
                contentViewModel.navigateToBlogViewButton(viewModel.blog.id, viewModel.post.categoryID) {
                    Text("더보기")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                }
            }
            .padding(.horizontal, 20)
        
            
            Spacer()
                .frame(height: 5)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(viewModel.categoryBlogPosts.prefix(4).enumerated()), id: \.offset) { index, post in
                    if index < 4 {
                        CategoryPostListCell(post: post)
                    }
                }
            }
        } //VStack
        .background(Color.white)
    }
}

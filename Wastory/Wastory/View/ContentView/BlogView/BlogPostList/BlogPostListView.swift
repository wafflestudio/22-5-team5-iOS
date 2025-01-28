//
//  BlogPostListView.swift
//  Wastory
//
//  Created by 중워니 on 1/8/25.
//

import SwiftUI

struct BlogPostListView: View {
//    @Environment(\.blogViewModel) var viewModel
    @Bindable var viewModel: BlogViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 30)
            
            Button(action: {
                viewModel.toggleIsCategorySheetPresent()
            }) {
                HStack(alignment: .center, spacing: 6) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 23, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .padding(.leading, 20)
                    
                    Text(viewModel.selectedCategory.categoryName) // selected category로 설정
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.primaryLabelColor)
                    
                    Spacer()
                }
            }
            
            Spacer()
                .frame(height: 5)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(viewModel.blogPosts.enumerated()), id: \.offset) { index, post in
                    BlogPostListCell(post: post, viewModel: viewModel)
                        .onAppear {
                            if index == viewModel.blogPosts.count - 1 {
                                Task {
                                    await viewModel.getPostsInCategory()
                                }
                            }
                        }
                }
            }
            
            Spacer()
                .frame(height: 100)
        } //VStack
    }
}

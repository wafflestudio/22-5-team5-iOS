//
//  CategoryPostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct CategoryPostListCell: View {
    let post: Post
    
//    @Environment(\.contentViewModel) var contentViewModel
//    @Environment(\.postViewModel) var viewModel
    
    @Bindable var viewModel: PostViewModel
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(post.title)
                        .font(.system(size: 20, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    Text(post.description ?? "")
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 7)
                    
                    HStack(spacing: 6) {
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "heart")
                            
                            Text("\(post.likeCount)")
                        }
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 3, weight: .light))
                            .foregroundStyle(Color.gray.opacity(0.3))
                        
                        //commentCount Text
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "ellipsis.bubble")
                            
                            Text("\(post.commentCount)")
                        }
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 3, weight: .light))
                            .foregroundStyle(Color.gray.opacity(0.3))
                        
                        //TimeAgo Text
                        Text("\(timeAgo(from: post.createdAt))")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
                
                Spacer()
                    .frame(width: 20)
                
                Spacer()
                
                KFImageWithoutDefault(imageURL: post.mainImageURL)
                    .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                    .frame(width: 100, height: 100)
                    .clipped()
            }//HStack
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
            
        } //VStack
        
        .background(Color.white)
        .overlay {
            NavigateToPostViewButton(post.id, viewModel.blog.id)
        }
    }
}

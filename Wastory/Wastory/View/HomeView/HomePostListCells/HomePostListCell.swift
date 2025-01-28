//
//  HomePostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct HomePostListCell: View {
    let post: Post
    
    @Environment(\.contentViewModel) var contentViewModel
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            contentViewModel.navigateToBlogViewButton(post.blogID) {
                HStack(spacing: 8) {
                    KFImageWithDefaultIcon(imageURL: post.blogMainImageURL)
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    
                    Text(post.blogName ?? "")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.primaryLabelColor)
                }
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(post.title)
                        .font(.system(size: 17, weight: .medium))
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 9)
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 3) {
                        Image(systemName: "heart")
                        Text("\(post.likeCount)")
                        
                        Spacer()
                            .frame(width: 5)
                        
                        Image(systemName: "ellipsis.bubble")
                        Text("\(post.commentCount)")
                        
                        Spacer()
                            .frame(width: 5)
                        
                        Text(timeAgo(from: post.createdAt))
                        
                        Spacer()
                    }
                    .font(.system(size: 13, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                }
                .padding(.trailing, 20)
                
                Spacer()
                
                KFImageWithoutDefault(imageURL: post.mainImageURL)
                    .scaledToFill()
                    .frame(width: 100, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        contentViewModel.navigateToPostViewButton(post.id, post.blogID)
                    }
            }
            
            Spacer()
                .frame(height: 17)
            
        }
        .padding(.horizontal, 20)
        .background {
            contentViewModel.navigateToPostViewButton(post.id, post.blogID)
        }
    }
}

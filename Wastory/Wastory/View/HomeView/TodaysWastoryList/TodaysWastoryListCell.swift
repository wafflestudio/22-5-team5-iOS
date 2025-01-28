//
//  TodaysWastoryListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//


import SwiftUI

struct TodaysWastoryListCell: View {
    let post: Post
    let index: Int
    
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 15)
            
            HStack(alignment: .center, spacing: 2) {
                Text("\(index)")
                    .font(.system(size: 25, weight: .black))
                    .foregroundStyle(Color.secondaryLabelColor)
                Text("/")
                    .font(.system(size: 15, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                
                contentViewModel.navigateToBlogViewButton(post.blogID) {
                    Text(post.blogName ?? "")
                        .font(.system(size: 11, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .padding(.top, 4)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 4)
            
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
            }
            
            Spacer()
                .frame(height: 17)
            
            if index != 5 {
                Divider()
                    .foregroundStyle(Color.secondaryLabelColor)
            }
        }// VStack
        .padding(.horizontal, 20)
        .background {
            contentViewModel.navigateToPostViewButton(post.id, post.blogID)
        }
    }
}

//
//  HomeBigPostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct HomeBigPostListCell: View {
    let post: Post
    
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 20)
                
                
                
                
                ZStack(alignment: .topLeading){
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 200)
                        .overlay {
                            ZStack {
                                KFImageWithDefault(imageURL: post.mainImageURL)
                                    .scaledToFill()
                                
                                Color.sheetOuterBackgroundColor
                                    .frame(height: 200)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.unreadNotification)
                        .padding(.horizontal, 20)
                        .overlay(
                            contentViewModel.navigateToPostViewButton(post.id, post.blogID)
                        )
                    
                    //블로그 정보 button
                    contentViewModel.navigateToBlogViewButton(post.blogID) {
                        HStack(alignment: .center, spacing: 8) {
                            // 블로그 mainImage
                            ZStack {
                                KFImageWithDefaultIcon(imageURL: post.blogMainImageURL)
                                    .scaledToFill()
                                    .clipShape(Circle())
                                
                                Circle()
                                    .stroke(Color.todaysWastoryTextColor, lineWidth: 1.7)
                            }
                            .frame(width: 23, height: 23)
                            
                            // 블로그 이름 Text
                            Text(post.blogName ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.todaysWastoryTextColor)
                                .lineLimit(1)
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.leading, 35)
                    .padding(.top, 15)
                } // ZStack
                
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 11)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(post.title)
                            .font(.system(size: 17, weight: .medium))
                            .lineLimit(2)
                        
                        Spacer()
                            .frame(height: 9)
                        
                        Text(post.description ?? "")
                            .font(.system(size: 14, weight: .light))
                            .lineLimit(2)
                            .foregroundStyle(Color.secondaryLabelColor)
                        
                        Spacer()
                            .frame(height: 9)
                        
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
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Divider()
                        .foregroundStyle(Color.secondaryLabelColor)
                }
                .padding(.horizontal, 20)
                .overlay(
                    contentViewModel.navigateToPostViewButton(post.id, post.blogID)
                    )
            } // VStack
        
    }
}


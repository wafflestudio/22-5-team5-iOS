//
//  BlogPostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/8/25.
//

import SwiftUI

struct BlogPostListCell: View {
    let post: Post
    @State var didAppear: Bool = false
    
//    @Environment(\.contentViewModel) var contentViewModel
//    @Environment(\.blogViewModel) var viewModel
    @Bindable var viewModel: BlogViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(post.title)
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text(post.description ?? "")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 7)
                    
                    HStack(spacing: 0) {
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "heart")
                            
                            Text("\(post.likeCount)")
                        }
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        //commentCount Text
                        if post.commentsEnabled ?? 1 == 1 {
                            HStack(alignment: .center, spacing: 3) {
                                Image(systemName: "ellipsis.bubble")
                                
                                Text("\(post.commentCount)")
                            }
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                            
                            
                            Spacer()
                                .frame(width: 15)
                        }
                        
                        //조회수 Text
                        Text("\(timeAgo(from: post.createdAt))")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        if post.protected == 1 {
                            Image(systemName: "lock")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                            
                            Spacer()
                                .frame(width: 15)
                        }
                        
                        if post.secret ?? 0 == 1 {
                            Image(systemName: "eye.slash")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                            
                            Spacer()
                                .frame(width: 15)
                        }
                    }
                }
                
                Spacer()
                    .frame(width: 20)
                
                Spacer()
                
                KFImageWithoutDefault(imageURL: post.mainImageURL)
                    .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                    .frame(width: 70, height: 70)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }//HStack
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
                .padding(.horizontal, 20)
            
        } //VStack
        
        .background(Color.white)
        .overlay {
            NavigateToPostViewButton(post.id, post.blogID)
        }
    }
}


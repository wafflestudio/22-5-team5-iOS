//
//  BlogPostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/8/25.
//

import SwiftUI

struct BlogPostListCell: View {
    let post: Post
    
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.blogViewModel) var viewModel
    
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
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "ellipsis.bubble")
                            
                            Text("\(post.commentCount)")
                        }
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        //조회수 Text
                        HStack(alignment: .center, spacing: 1) {
                            Text("5")
                            
                            Text("시간 전")
                        }
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
                
                Spacer()
                    .frame(width: 20)
                
                Spacer()
                
                Image(systemName: "questionmark.text.page.fill")
                    .resizable()
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
            contentViewModel.navigateToPostViewButton(tempPost())
        }
    }
}


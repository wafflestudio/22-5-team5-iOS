//
//  CommentCell.swift
//  Wastory
//
//  Created by 중워니 on 1/16/25.
//

import SwiftUI

struct CommentCell: View {
    var comment: Comment
    let isChild: Bool
    
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            HStack(alignment: .top, spacing: 0) {
                
                if isChild {
                    Text("ㄴ")
                        .font(.system(size: 20, weight: .ultraLight))
                        .foregroundStyle(Color.secondaryLabelColor)
                        .padding(.top, 5)
                        .padding(.trailing, 10)
                }
                
                
                Button(action: {
                    contentViewModel.navigateToBlog(contentViewModel.navigationBlog) // 추후 해당 Blog 전달
                }) {
                    Image(systemName: "questionmark.text.page.fill")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                    .frame(width: 10)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Button(action: {
                            contentViewModel.navigateToBlog(contentViewModel.navigationBlog) // 추후 해당 Blog 전달
                        }) {
                            Text("블로그 이름")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.primaryLabelColor)
                        }
                        
                        Image(systemName: "lock")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(comment.isSecret ? Color.secondaryLabelColor : Color.clear)
                    }
                    Spacer()
                        .frame(height: 3)
                    
                    Text(comment.content)
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    HStack(spacing: 6) {
                        Text("5시간전")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.secondaryLabelColor)
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 3, weight: .regular))
                            .foregroundStyle(Color.gray.opacity(0.3))
                        
                        Button(action: {
                            //답글
                        }) {
                            Text("답글")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(Color.secondaryLabelColor)
                        }
                    }
                    
                }
                
                Spacer()
                Spacer()
                    .frame(width: 10)
                
                Button(action: {
                    //더보기 : 신고 or 수정 / 삭제 sheet 보여주기
                }) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                }
            } //HStack1
            .padding(.horizontal, 20)
            
            Spacer()
                    .frame(height: 20)
            
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
            
            if !isChild {
                ForEach(comment.children ?? []) { child in
                    CommentCell(comment: child, isChild: true)
                }
            }
        }//VStack1
    }
}


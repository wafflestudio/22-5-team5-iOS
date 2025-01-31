//
//  CommentCell.swift
//  Wastory
//
//  Created by 중워니 on 1/16/25.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    var comment: Comment
    let isChild: Bool
    let rootComment: Comment
    
    @Bindable var viewModel: CommentViewModel
    
//    @Environment(\.contentViewModel) var contentViewModel
    
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
                
                
                if viewModel.isMyBlog || comment.blogID == UserInfoRepository.shared.getBlogID() {
                    NavigateToBlogViewButton(comment.blogID) {
                        KFImageWithDefaultIcon(imageURL: comment.blogMainImageURL)
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                        .frame(width: 10)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 5) {
                            NavigateToBlogViewButton(tempBlog().id) {
                                Text(comment.userName)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.primaryLabelColor)
                            }
                            
                            Image(systemName: "lock")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(comment.isSecret == 1 ? Color.secondaryLabelColor : Color.clear)
                        }
                        Spacer()
                            .frame(height: 3)
                        
                        Text(comment.content)
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(comment.isSecret == 1 ? Color.secondaryLabelColor : Color.primaryLabelColor)
                        
                        Spacer()
                            .frame(height: 10)
                        
                        HStack(spacing: 6) {
                            Text("\(timeAgo(from: comment.createdAt))")
                                .font(.system(size: 14, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                            
                            Image(systemName: "circle.fill")
                                .font(.system(size: 3, weight: .regular))
                                .foregroundStyle(Color.gray.opacity(0.3))
                            
                            Button(action: {
                                viewModel.updateIsTextFieldFocused()
                                viewModel.setTargetComment(to: rootComment)
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
                        viewModel.setEditComment(to: comment)
                        viewModel.toggleIsCommentSheetPresent()
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color.primaryLabelColor)
                    }
                } else {
                    if comment.isSecret == 0 {
                        NavigateToBlogViewButton(comment.blogID) {
                            KFImageWithDefaultIcon(imageURL: comment.blogMainImageURL)
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                        }
                        
                        Spacer()
                            .frame(width: 10)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 5) {
                                NavigateToBlogViewButton(tempBlog().id) {
                                    Text(comment.userName)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.primaryLabelColor)
                                }
                            }
                            Spacer()
                                .frame(height: 3)
                            
                            Text(comment.content)
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(Color.primaryLabelColor)
                            
                            Spacer()
                                .frame(height: 10)
                            
                            HStack(spacing: 6) {
                                Text("\(timeAgo(from: comment.createdAt))")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                                
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 3, weight: .regular))
                                    .foregroundStyle(Color.gray.opacity(0.3))
                                
                                Button(action: {
                                    viewModel.updateIsTextFieldFocused()
                                    viewModel.setTargetComment(to: rootComment)
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
                    } else if comment.isSecret == 1 {
                        KFImageWithDefaultIcon(imageURL: "")
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                            .frame(width: 10)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 5) {
                                Text("익명")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.primaryLabelColor)
                                Image(systemName: "lock")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                            Spacer()
                                .frame(height: 3)
                            
                            Text("비밀댓글입니다.")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(Color.secondaryLabelColor)
                            
                            Spacer()
                                .frame(height: 10)
                            
                            HStack(spacing: 6) {
                                Text("\(timeAgo(from: comment.createdAt))")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundStyle(Color.secondaryLabelColor)
                            }
                            
                        }
                        
                        Spacer()
                        Spacer()
                            .frame(width: 10)
                    }
                }
            } //HStack1
            .padding(.horizontal, 20)
            
            Spacer()
                    .frame(height: 20)
            
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
            
            if !isChild {
                ForEach(comment.children ?? []) { child in
                    CommentCell(comment: child, isChild: true, rootComment: comment, viewModel: viewModel)
                }
            }
        }//VStack1
    }
}


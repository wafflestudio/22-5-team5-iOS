//
//  TodaysWastoryPageTabCell.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct TodaysWastoryPageTabCell: View {
    let post: Post
    
    @Environment(\.contentViewModel) var contentViewModel
    
    
    var body: some View {
        ZStack {
            //Background Image
            GeometryReader { geometry in
                KFImageWithDefault(imageURL: post.mainImageURL)
                    .scaledToFill()
                    .frame(width: geometry.size.width ,height: geometry.size.height)
                    .clipped()
                    .foregroundStyle(Color.unreadNotification)
            }
            
            //Background Dimming
            Color.sheetOuterBackgroundColor
            
            
            VStack(spacing: 0) {
                // 오늘의 와스토리 Text
                HStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.todaysWastoryTextOutterBoxColor, lineWidth: 1.5)
                            .frame(width: 90, height: 26)
                        
                        Text("오늘의 와스토리")
                            .font(.system(size: 11, weight: .light))
                            .foregroundStyle(Color.todaysWastoryTextColor)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 23)
                }
                
                Spacer()
                
                // 글 정보
                VStack(alignment: .leading, spacing: 0) {
                    // 글 제목
                    HStack(spacing: 0) {
                        Image(systemName: "quote.opening")
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundStyle(Color.todaysWastoryTextColor)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    
                    Text(post.title)
                        .font(.system(size: 23, weight: .semibold))
                        .foregroundStyle(Color.todaysWastoryTextColor)
                        .lineLimit(3)
                        .padding(.bottom, 15)
                    
                    // 블로그 정보
                    HStack {
                        contentViewModel.navigateToBlogViewButton(post.blogID) {
                            HStack(spacing: 8) {
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
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 22)
                }//Vstack
                .padding(.horizontal, 25)
            }//Vstack
            .background {
                contentViewModel.navigateToPostViewButton(post.id, post.blogID)
            }
        }//ZStack
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


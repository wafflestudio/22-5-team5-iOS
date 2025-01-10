//
//  HomeBigPostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct HomeBigPostListCell: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 20)
                
                ZStack(alignment: .topLeading){
                    ZStack {
                        //Background Image
                        Image(systemName: "questionmark.text.page.fill")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .foregroundStyle(Color.unreadNotification)
                            .frame(height: 200)
                        
                        //Background Dimming
                        Color.sheetOuterBackgroundColor
                            .frame(height: 200)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 20)
                    .overlay(
                        contentViewModel.openNavigationLinkWithPostButton()
                        )
                    
                    
                    //블로그 정보 button
                    NavigationLink(destination: BlogView()) {
                        Button(action: {
                            // TODO: 해당 블로그 View로 이동
                            contentViewModel.openNavigationStackWithBlog()
                        }) {
                            // 블로그 mainImage
                            ZStack {
                                Image(systemName: "questionmark.text.page.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                
                                Circle()
                                    .stroke(Color.todaysWastoryTextColor, lineWidth: 1.7)
                            }
                            .frame(width: 23, height: 23)
                            
                            // 블로그 이름 Text
                            Text("블로그이름")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.todaysWastoryTextColor)
                        }
                    }
                    .padding(.leading, 35)
                    .padding(.top, 15)
                } // ZStack
                
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                        .frame(height: 11)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목목제목제목제목제목제목제목제목")
                            .font(.system(size: 17, weight: .medium))
                            .lineLimit(2)
                        
                        Spacer()
                            .frame(height: 9)
                        
                        Text("내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")
                            .font(.system(size: 14, weight: .light))
                            .lineLimit(2)
                            .foregroundStyle(Color.secondaryLabelColor)
                        
                        Spacer()
                            .frame(height: 9)
                        
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "heart")
                            Text("50")
                            
                            Spacer()
                                .frame(width: 5)
                            
                            Image(systemName: "ellipsis.bubble")
                            Text("5")
                            
                            Spacer()
                                .frame(width: 5)
                            
                            Text("5분 전")
                            
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
                    contentViewModel.openNavigationLinkWithPostButton()
                    )
            } // VStack
        
    }
}

#Preview {
    HomeBigPostListCell()
}

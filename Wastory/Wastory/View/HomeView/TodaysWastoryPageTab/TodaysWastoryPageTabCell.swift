//
//  TodaysWastoryPageTabCell.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct TodaysWastoryPageTabCell: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    
    
    var body: some View {
        ZStack {
            //Background Image
            GeometryReader { geometry in
                Image(systemName: "questionmark.text.page.fill")
                    .resizable()
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
                    
                    Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목")
                        .font(.system(size: 23, weight: .semibold))
                        .foregroundStyle(Color.todaysWastoryTextColor)
                        .lineLimit(3)
                        .padding(.bottom, 15)
                    
                    // 블로그 정보
                    HStack {
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
                        
                        Spacer()
                    }
                    .padding(.bottom, 22)
                }
                .padding(.horizontal, 25)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


extension Color {
    static let todaysWastoryTextOutterBoxColor = Color.white.opacity(0.5)
    static let todaysWastoryTextColor = Color.white
}

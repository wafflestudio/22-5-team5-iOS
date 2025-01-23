//
//  BlogHeaderView.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct BlogHeaderView: View {
    let blog: Blog
    
    var body: some View {
        ZStack{
            Color.loadingCoralRed// 임시 배경 TODO: Blog.mainImage의 대표 색을 추출해 그라데이션으로 표현
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 120)
                
                Text(blog.blogName)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color.primaryDarkModeLabelColor)
                
                Spacer()
                    .frame(height: 10)
                
                HStack(spacing: 5) {
                    Text("구독자")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.secondaryDarkModeLabelColor)
                    
                    Text("2025")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.primaryDarkModeLabelColor)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 17)
                
                Text(blog.description)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.secondaryDarkModeLabelColor)
                    .lineSpacing(4)
                
                Spacer()
                    .frame(height: 17)
                
                HStack(spacing: 10) {
                    Button(action: {
                        //User.subscribingBlogID에 추가
                    }) {
                        ZStack {
                            Color.white // 버튼 배경 흰색
                            Text("구독하기")
                                .font(.system(size: 14, weight: .light))
                                .blendMode(.destinationOut) // 텍스트를 배경에서 투명하게 처리
                        }
                        .compositingGroup() // 블렌드 모드 적용
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 100, height: 35)
                    
                    Button(action: {
                        //방명록 View로 이동
                    }) {
                        Text("방명록")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(Color.primaryDarkModeLabelColor)
                            .frame(width: 87, height: 35)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(Color.secondaryDarkModeLabelColor)
                            )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        //공유 / 미구현시 제거
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.primaryDarkModeLabelColor)
                            .offset(y: -2)
                            .frame(width: 35, height: 35)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(Color.secondaryDarkModeLabelColor)
                            )
                    }
                    
                }
                
                Spacer()
                    .frame(height: 25)
            }
            
            .padding(.horizontal, 20)
        }
    }
}

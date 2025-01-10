//
//  CategoryPostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct CategoryPostListCell: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.postViewModel) var viewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목")
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Text("내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 7)
                    
                    HStack(spacing: 0) {
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "heart")
                            
                            Text("50")
                        }
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        //commentCount Text
                        HStack(alignment: .center, spacing: 3) {
                            Image(systemName: "ellipsis.bubble")
                            
                            Text("5")
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
                
                Image(systemName: "questionmark.text.page.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                    .frame(width: 70, height: 70)
            }//HStack
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
            
        } //VStack
        
        .background(Color.white)
        .onTapGesture {
            contentViewModel.pushNavigationStack(isNavigationToNext: &viewModel.isNavigationToNextPost)
        }
    }
}


#Preview {
    BlogPostListCell()
}

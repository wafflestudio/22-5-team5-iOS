//
//  SearchedBlogCell.swift
//  Wastory
//
//  Created by 중워니 on 1/18/25.
//

import SwiftUI

struct BasicBlogCell: View {
    let blog: Blog
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "questionmark.text.page.fill")
                .resizable()
                .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(blog.blogName)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.primaryLabelColor)
                    .lineLimit(1)
                
                Text(blog.description)
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                    .lineLimit(1)
            }
            
            Spacer()
            Spacer()
                .frame(width: 20)
            
            Button(action: {
                //구독추가
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.primaryLabelColor)
                    .frame(width: 25, height: 25)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundStyle(Color.primaryLabelColor)
                    )
                    
                //TODO: 구독중인지에 따라 다르게 표시
            }
        }
        .padding(20)
        .background(Color.white)
        .overlay {
            contentViewModel.navigateToBlogViewButton(tempBlog().id) {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundStyle(Color.clear)
            }
        }
        
    }
}

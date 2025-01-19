//
//  HomePostListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct HomePostListCell: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            contentViewModel.openNavigationStackWithBlogButton(tempBlog()) {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.text.page.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    
                    Text("블로그 이름")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.primaryLabelColor)
                }
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목")
                        .font(.system(size: 17, weight: .medium))
                        .lineLimit(2)
                    
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
                .padding(.trailing, 20)
                
                Spacer()
                
                Image(systemName: "questionmark.text.page.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Spacer()
                .frame(height: 17)
            
            if index != 4 {
                Divider()
                    .foregroundStyle(Color.secondaryLabelColor)
            }
        }
        .padding(.horizontal, 20)
        .background {
            contentViewModel.openNavigationStackWithPostButton(tempPost())
        }
    }
}

#Preview {
    HomePostListCell(index: 5)
}

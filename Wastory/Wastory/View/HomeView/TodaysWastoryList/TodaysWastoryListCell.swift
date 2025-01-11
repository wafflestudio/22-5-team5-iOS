//
//  TodaysWastoryListCell.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//


import SwiftUI

struct TodaysWastoryListCell: View {
    let index: Int
    
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 15)
            
            HStack(alignment: .center, spacing: 2) {
                Text("\(index)")
                    .font(.system(size: 25, weight: .black))
                    .foregroundStyle(Color.secondaryLabelColor)
                Text("/")
                    .font(.system(size: 15, weight: .light))
                    .foregroundStyle(Color.secondaryLabelColor)
                
                contentViewModel.openNavigationStackWithBlogButton {
                    Text("블로그 이름")
                        .font(.system(size: 11, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .padding(.top, 4)
                }
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 4)
            
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
            
            if index != 5 {
                Divider()
                    .foregroundStyle(Color.secondaryLabelColor)
            }
        }// VStack
        .padding(.horizontal, 20)
        .background {
            contentViewModel.openNavigationStackWithPostButton()
        }
    }
}

#Preview {
    TodaysWastoryListCell(index: 1)
}

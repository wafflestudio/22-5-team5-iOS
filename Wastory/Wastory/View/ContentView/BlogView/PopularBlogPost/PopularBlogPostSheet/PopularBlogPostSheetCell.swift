//
//  PopularBlogPostSheetCell.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct PopularBlogPostSheetCell: View {
    let index: Int
    @Bindable var viewModel: PopularBlogPostSheetViewModel
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Text("\(index)")
                    .foregroundStyle(Color.loadingCoralRed)
                    .font(.system(size: 18, weight: .light))
                    .frame(width: 25)
                
                Spacer()
                    .frame(width: 10)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("제목제목제목제목제목제목제목제목제목제목제목제목제목제목")
                        .font(.system(size: 18, weight: .light))
                        .lineLimit(1)
                    
                    Spacer()
                        .frame(height: 10)
                    
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
                        HStack(alignment: .center, spacing: 3) {
                            Text("조회")
                            
                            Text("999+")
                        }
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
                
                Spacer()
                    .frame(width: 20)
                
                Spacer()
                
                Image(systemName: "questionmark.text.page.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill) // 이미지비율 채워서 자르기
                    .frame(width: 50, height: 50)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }//HStack
            .padding(.vertical, 15)
            .padding(.trailing, 20)
            .padding(.leading, 10)
            
            
        } //VStack
        .background(Color.white)
        .overlay {
            contentViewModel.openNavigationStackWithPostButton(tempPost())
        }
    }
}

//
//  CategoryPopularPostView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct CategoryPopularPostView: View {
    @Bindable var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            HStack(spacing: 0) {
                Text("카테고리 인기글")
                    .font(.system(size: 22, weight: .black))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
            }
            .padding(.leading, 5)
            .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 12)
            
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    Spacer()
                        .frame(width: 20)
                    ForEach(viewModel.categoryList, id: \.self) { category in
                        categoryButton(category: category, isSelected: viewModel.selectedCategory == category)
                    }
                    Spacer()
                        .frame(width: 20)
                }
            }
            .scrollIndicators(.hidden)
            .zIndex(1)
            
            VStack(spacing: 0) {
                ForEach(Array(viewModel.categoryPopularPostItems[0..<2].enumerated()), id: \.offset) { index, item in
                    HomeBigPostListCell()
                }
            }
            .padding(.horizontal, 20)
            
            VStack(spacing: 0) {
                ForEach(Array(viewModel.categoryPopularPostItems[2..<7].enumerated()), id: \.offset) { index, item in
                    HomePostListCell(index: index)
                }
            }
            .padding(.horizontal, 20)
        } //VStack
    } //Body
    
    @ViewBuilder func categoryButton(category: String, isSelected: Bool) -> some View {
        Button(action: {
            viewModel.selectedCategory = category
        }) {
            HStack(spacing: 3) {
                Image(systemName: viewModel.categoryIcons[category]!)
                    .font(.system(size: 14))
                Text(category)
                    .font(.system(size: 14, weight: isSelected ? .bold : .light))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .foregroundStyle(isSelected ? Color.white : Color.black)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(isSelected ? Color.black : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(isSelected ? Color.clear : Color.middleDotColor, lineWidth: 1)
                    )
                    .shadow(color: isSelected ? Color.clear : Color.black.opacity(0.13), radius: 3, x: 0, y: 3)
            )
        }
        .padding(.top, 2)
        .padding(.bottom, 10)
        
    }
}

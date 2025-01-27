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
                    ForEach(viewModel.categoryList) { category in
                        categoryButton(category: category, isSelected: viewModel.selectedCategory.id == category.id)
                    }
                    Spacer()
                        .frame(width: 20)
                }
            }
            .scrollIndicators(.hidden)
            .zIndex(1)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(viewModel.categoryPopularPostItems.prefix(2).enumerated()), id: \.offset) { index, item in
                    if index < 2 {
                        HomeBigPostListCell()
                    } else {
                        HomePostListCell(index: index)
                    }
                }
            }
            
        } //VStack
        .background(Color.white)
    } //Body
    
    @ViewBuilder func categoryButton(category: HomeTopic, isSelected: Bool) -> some View {
        Button(action: {
            viewModel.selectedCategory = category
            Task {
                await viewModel.getCategoryPopularPostItems()
            }
        }) {
            HStack(spacing: 3) {
                Image(systemName: viewModel.categoryIcons[category.id] ?? "")
                    .font(.system(size: 14))
                Text(category.name)
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

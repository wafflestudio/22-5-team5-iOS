//
//  ArticleCategorySheet.swift
//  Wastory
//
//  Created by mujigae on 1/27/25.
//

import SwiftUI

struct ArticleCategorySheet: View {
    @Bindable var viewModel: ArticleSettingViewModel
    
    var body: some View {
        ZStack {
            // MARK: Background Dimming
            (viewModel.isCategorySheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.toggleIsCategorySheetPresent()
                }

            VStack {
                Spacer()
                if viewModel.isCategorySheetPresent {
                    let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.6
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                                .frame(height: 30)
                            HStack {
                                Text("카테고리 선택")
                                    .font(.system(size: 28, weight: .regular))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .padding(.leading, 20)
                                    .padding(.bottom, 16)
                                Spacer()
                            }
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                                        CategoryButton(for: category, isLast: index == viewModel.getCategoriesCount() - 1, rowHeight: 60)
                                    }
                                }
                                Spacer()
                                    .frame(height: 30)
                            }
                        }
                        .frame(height: sheetHeight)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    .background(Color.clear)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: viewModel.isCategorySheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: CategorySheet Row
    @ViewBuilder func CategoryButton(for category: Category, isLast: Bool, rowHeight: CGFloat) -> some View {
        Button(action: {
            viewModel.setCategory(category: category)
            viewModel.toggleIsCategorySheetPresent()
        }) {
            HStack(spacing: 0) {
                Text(category.categoryName)
                    .font(.system(size: 17, weight: .light))
                    .padding()
                Spacer()
            }
            .foregroundStyle(viewModel.isSelectedCategory(category: category) ? Color.loadingCoralRed : Color.primaryLabelColor)
        }
        .frame(height: rowHeight)
        .frame(maxWidth: .infinity)
        
        ForEach(Array((category.children ?? []).enumerated()), id: \.offset) { index, child in
            Button(action: {
                viewModel.setCategory(category: child)
                viewModel.toggleIsCategorySheetPresent()
            }) {
                HStack(spacing: 0) {
                    Text("ㄴ \(child.categoryName)")
                        .font(.system(size: 15, weight: .light))
                        .padding()
                    Spacer()
                }
                .foregroundStyle(viewModel.isSelectedCategory(category: child) ? Color.loadingCoralRed : Color.primaryLabelColor)
            }
            .frame(height: rowHeight)
            .frame(maxWidth: .infinity)
        }
        
        if !isLast {
            SettingDivider(thickness: 1)
        }
    }
}

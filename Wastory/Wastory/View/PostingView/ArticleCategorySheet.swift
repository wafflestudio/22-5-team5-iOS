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
                    viewModel.toggleCategorySheetPresent()
                }

            VStack {
                Spacer()
                if viewModel.isCategorySheetPresent {
                    let sheetTopSpace: CGFloat = 30
                    let sheetRowHeight: CGFloat = 60
                    let sheetBottomSpace: CGFloat = 30
                    let sheetTitleHeight: CGFloat = 50
                    let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.6
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                                .frame(height: sheetTopSpace)
                            
                            Text("카테고리")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundStyle(Color.primaryLabelColor)
                                .frame(height: sheetTitleHeight)
                                .padding(.leading, 20)
                            ScrollView {
                                VStack(spacing: 0) {/*
                                    ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                                        
                                        CategoryButton(for: category, isLast: index == viewModel.getCategoriesCount() - 1, rowHeight: sheetRowHeight)
                                    }*/
                                }
                                
                                Spacer()
                                    .frame(height: sheetBottomSpace)
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
}

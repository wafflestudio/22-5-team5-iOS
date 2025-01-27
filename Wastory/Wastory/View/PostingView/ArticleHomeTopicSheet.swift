//
//  ArticleHomeTopicSheet.swift
//  Wastory
//
//  Created by mujigae on 1/28/25.
//

import SwiftUI

struct ArticleHomeTopicSheet: View {
    @Bindable var viewModel: ArticleSettingViewModel
    
    var body: some View {
        ZStack {
            // MARK: Background Dimming
            (viewModel.isHomeTopicSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.toggleIsHomeTopicSheetPresent()
                }

            VStack {
                Spacer()
                if viewModel.isHomeTopicSheetPresent {
                    let sheetTopSpace: CGFloat = 30
                    let sheetRowHeight: CGFloat = 60
                    let sheetBottomSpace: CGFloat = 30
                    let sheetTitleHeight: CGFloat = 50
                    let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.6
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                                .frame(height: sheetTopSpace)
                            HStack {
                                Text("카테고리")
                                    .font(.system(size: 30, weight: .regular))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .frame(height: sheetTitleHeight)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            ScrollView {
                                VStack(spacing: 0) {
                                    /*
                                    ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                                        CategoryButton(for: category, isLast: index == viewModel.getCategoriesCount() - 1, rowHeight: sheetRowHeight)
                                    }
                                     */
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
                    .animation(.easeInOut, value: viewModel.isHomeTopicSheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
}

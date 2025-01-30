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
                    let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.8
                    let buttonWidth: CGFloat =
                        UIScreen.main.bounds.width * 0.35
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                                .frame(height: 30)
                            HStack {
                                Text("홈주제")
                                    .font(.system(size: 28, weight: .regular))
                                    .foregroundStyle(Color.primaryLabelColor)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 16)
                                Spacer()
                            }
                            Spacer()
                                .frame(height: 10)
                            ScrollView {
                                Spacer()
                                    .frame(height: 10)
                                HStack {
                                    HomeTopicButton(homeTopic: viewModel.defaultHomeTopic, buttonWidth: buttonWidth)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                Spacer()
                                    .frame(height: 24)
                                
                                VStack(spacing: 24) {
                                    ForEach(viewModel.highCategories, id: \.self) { highCategory in
                                        HomeTopicBlock(highCategory: highCategory, buttonWidth: buttonWidth)
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
                    .animation(.easeInOut, value: viewModel.isHomeTopicSheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: HomeTopicSheet Row
    @ViewBuilder func HomeTopicBlock(highCategory: HomeTopic, buttonWidth: CGFloat) -> some View {
        VStack(spacing: 10) {
            HStack {
                Text(highCategory.name)
                    .font(.system(size: 15, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 20)
            
            ForEach(Array(stride(from: 0, to: viewModel.homeTopics[highCategory.id - 2].count, by: 2)), id: \.self) { index in
                HStack(spacing: 0) {
                    HomeTopicButton(homeTopic: viewModel.homeTopics[highCategory.id - 2][index], buttonWidth: buttonWidth)
                        .padding(.leading, 20)
                    Spacer()
                    if index + 1 < viewModel.homeTopics[highCategory.id - 2].count {
                        HomeTopicButton(homeTopic: viewModel.homeTopics[highCategory.id - 2][index + 1], buttonWidth: buttonWidth)
                            .padding(.trailing, 20)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder func HomeTopicButton(homeTopic: HomeTopic, buttonWidth: CGFloat) -> some View {
        Button {
            viewModel.setHomeTopic(homeTopic: homeTopic)
            viewModel.toggleIsHomeTopicSheetPresent()
        } label: {
            HStack {
                Text(homeTopic.name)
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(viewModel.isSelectedHomeTopic(homeTopic: homeTopic) ? Color.loadingCoralRed : .black)
                    .padding(.leading, 10)
                    .padding(.vertical, 10)
                Spacer()
                if viewModel.isSelectedHomeTopic(homeTopic: homeTopic) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(Color.loadingCoralRed)
                        .padding(.trailing, 10)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(viewModel.isSelectedHomeTopic(homeTopic: homeTopic) ? Color.loadingCoralRed : Color.articleImageBackgroundGray, lineWidth: 1)
        )
        .frame(width: buttonWidth)
    }
}

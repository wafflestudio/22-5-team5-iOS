//
//  ArticleDraftSheet.swift
//  Wastory
//
//  Created by mujigae on 1/28/25.
//

import SwiftUI

struct ArticleDraftSheet: View {
    @Bindable var viewModel: ArticleViewModel
    
    var body: some View {
        ZStack {
            // MARK: Background Dimming
            (viewModel.isDraftSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.toggleIsDraftSheetPresent()
                }

            VStack {
                Spacer()
                if viewModel.isDraftSheetPresent {
                    let sheetHeight: CGFloat = UIScreen.main.bounds.height * 0.8
                    
                    ZStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Spacer()
                                .frame(height: 30)
                            HStack(alignment: .top, spacing: 5) {
                                Text("임시저장")
                                    .font(.system(size: 28, weight: .regular))
                                    .foregroundStyle(Color.primaryLabelColor)
                                Text(String(viewModel.getDraftsCount()))
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 16)
                            Spacer()
                                .frame(height: 10)
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(Array(viewModel.drafts.enumerated()), id: \.offset) { index, draft in
                                        DraftButton(draft: draft)
                                            .onAppear {
                                                if index == viewModel.drafts.count - 1 {
                                                    Task {
                                                        await viewModel.getDrafts()
                                                    }
                                                }
                                            }
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
                    .animation(.easeInOut, value: viewModel.isDraftSheetPresent)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: DraftSheet Row
    @ViewBuilder func DraftButton(draft: DraftDto) -> some View {
        Button {
            Task {
                await viewModel.getDraft(draftID: draft.id)
                viewModel.toggleIsDraftSheetPresent()
            }
        } label: {
            VStack(spacing: 5) {
                HStack {
                    Text(draft.title.isEmpty ? "제목 없음" : draft.title)
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(.black)
                    Spacer()
                }
                HStack {
                    Text(timeAgo(from: draft.createdAt))
                        .font(.system(size: 12, weight: .light))
                        .foregroundStyle(Color.emailCautionTextGray)
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        SettingDivider(thickness: 1)
    }
}

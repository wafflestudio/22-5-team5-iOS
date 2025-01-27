//
//  PostingView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//  Modified by mujigae on 1/13/25.
//

import SwiftUI
import RichTextKit

struct PostingView: View {
    @Bindable var mainTabViewModel: MainTabViewModel
    @State private var viewModel = PostingViewModel()
    
    @FocusState private var isTitleFocused: Bool
    @FocusState private var isTextFocused: Bool
    
    var body: some View {
        VStack {
            // MARK: Title TextField
            TextField("제목", text: $viewModel.title)
                .font(.system(size: 26, weight: .regular))
                .foregroundStyle(Color.primaryLabelColor)
                .focused($isTitleFocused)
                .autocapitalization(.none)
                .padding(.top, 20)
                .padding(.horizontal, 23)
            
            Spacer()
                .frame(height: 10)
            
            // MARK: Contents TextField
            ZStack(alignment: .topLeading) {
                if viewModel.text.string.isEmpty {
                    HStack {
                        Text("내용을 입력해주세요.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.promptLabelColor)
                            .padding(.horizontal, 26)
                            .padding(.top, 9)
                        Spacer()
                    }
                }
                RichTextEditor(text: $viewModel.text, context: viewModel.context)
                    .focusedValue(\.richTextContext, viewModel.context)
                    .focused($isTextFocused)
                    .padding(.horizontal, 18)
            }
            RichTextKeyboardToolbar(
                context: viewModel.context,
                leadingButtons: { _ in },
                trailingButtons: { _ in },
                formatSheet: { $0 }
            )
            Spacer()
        }
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(Color.white)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    mainTabViewModel.toggleIsPostingViewPresent()
                }) {
                    Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .light))
                }
            }
            // TODO: 임시저장버튼 & 완료 버튼
            ToolbarItem {
                HStack {
                    HStack(spacing: 0) {
                        Button {
                            // 임시 저장 기능
                            Task {
                                await viewModel.postArticle()
                            }
                        } label: {
                            Text("저장")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 10)
                        }
                        Rectangle()
                            .frame(width: 1, height: 10)
                            .foregroundStyle(Color.codeRequestButtonGray)
                        Button {
                            // 임시 저장한 글들을 불러 오는 기능
                        } label: {
                            Text(viewModel.getTempPostCount())
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(.black)
                                .padding(.vertical, 3)
                                .padding(.leading, 4)
                                .padding(.trailing, 18)
                        }
                    }
                    .background(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                    )
                    .padding(.trailing, 5)
                    NavigationLink(destination: PostSettingView(viewModel: PostSettingViewModel(title: viewModel.title, text: viewModel.text))) {
                        Text("완료")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.black)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 7)
                            .padding(.trailing, 7)
                    }
                    .background(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.codeRequestButtonGray, lineWidth: 1)
                    )
                    .padding(.trailing, 10)
                }
            }
        }
    }
}

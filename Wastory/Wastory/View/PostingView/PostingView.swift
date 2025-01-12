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
                .padding(.top, 20)
                .padding(.horizontal, 20)
            
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
        }
    }
}

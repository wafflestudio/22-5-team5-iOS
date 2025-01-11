//
//  PostingView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct PostingView: View {
    @Bindable var mainTabViewModel: MainTabViewModel
    @State private var viewModel = PostingViewModel()
    @State private var richText = NSAttributedString()
    
    var body: some View {
        ScrollView {
            VStack {
                // MARK: Title TextField
                TextField("제목", text: $viewModel.title)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundStyle(Color.primaryLabelColor)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Contents TextField
                ZStack(alignment: .topLeading) {
                    if richText.string.isEmpty {
                        HStack {
                            Text("내용을 입력해주세요.")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(Color.promptLabelColor)
                                .padding(.horizontal, 20)
                                .padding(.top, 12)
                            Spacer()
                        }
                    }
                    RichTextEditor(text: $richText)
                        .frame(height: 300)
                        .padding(.horizontal, 15)
                }
                Spacer()
            }
        }
        .toolbarBackgroundVisibility(.visible)
        .toolbarBackground(Color.white)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
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

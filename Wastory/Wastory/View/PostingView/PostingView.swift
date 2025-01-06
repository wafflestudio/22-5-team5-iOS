//
//  PostingView.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//

import SwiftUI

struct PostingView: View {
    
    @Bindable var mainTabViewModel: MainTabViewModel
    @State var viewModel = PostingViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Title TextField
                TextField("제목", text: $viewModel.title)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Contents TextField
                TextField("내용을 입력해주세요", text: $viewModel.content)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.primaryLabelColor)
                    
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
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

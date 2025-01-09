//
//  PostView.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI

struct PostView: View {
    @State private var viewModel = PostViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                print("newValeue: \(newValue), oldValue: \(oldValue)")
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    Color.clear.frame(height: 1000)
                    
                }
            }// ScrollView
        }// VStack
        .ignoresSafeArea(edges: .all)
        // MARK: NavBar
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    contentViewModel.pushNavigationStack(isNavigationToNext: &viewModel.isNavigationToNextBlog)
                } label: {
                    Text(Image(systemName: "magnifyingglass"))
                        .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                }
                .navigationDestination(isPresented: $viewModel.isNavigationToNextPost) {
                    BlogView()
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    contentViewModel.backButtonAction {
                        dismiss()
                    }
                } label: {
                    Text(Image(systemName: "chevron.backward"))
                        .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                }
            }
        } //toolbar
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    @Previewable @State var contentViewModel = ContentViewModel()
    PostView()
        .environment(\.contentViewModel, contentViewModel)
}

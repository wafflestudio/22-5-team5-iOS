//
//  BlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct BlogView: View {
    @State var viewModel = BlogViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    BlogHeaderView()
                    
                    Button(action: {
                        // TODO: 해당 블로그 View로 이동
                        contentViewModel.pushNavigationStackWithBlog(isNavigationToNextBlog: &viewModel.isNavigationToNextPost)
                    }) {
                        // 블로그 mainImage
                        ZStack {
                            Image(systemName: "questionmark.text.page.fill")
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                            
                            Circle()
                                .stroke(Color.todaysWastoryTextColor, lineWidth: 1.7)
                        }
                        .frame(width: 23, height: 23)
                        
                        // 블로그 이름 Text
                        Text("블로그이름")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.todaysWastoryTextColor)
                    }
                    .navigationDestination(isPresented: $viewModel.isNavigationToNextPost) {
                        BlogView()
                    }
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    // 인기글 TODO: 인기글 모두보기 View
                    PopularBlogPostListView(viewModel: viewModel)
                    
                    // 카테고리 별 글 TODO: 카테고리 선택 sheet 및 카테고리 별로 분류
                    BlogPostListView(viewModel: viewModel)
                    
                    Spacer()
                        .frame(height: 100)
                } //VStack
            } //ScrollView
        } //VStack
        .ignoresSafeArea(edges: .all)
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(viewModel.getIsNavTitleHidden() ? "" : "블로그 이름")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(viewModel.getIsNavTitleHidden() ? .hidden : .visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    
                } label: {
                    Text(Image(systemName: "magnifyingglass"))
                        .foregroundStyle(viewModel.getIsNavTitleHidden() ? Color.white : Color.black)
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    contentViewModel.removeNavigationStackCount()
                    if contentViewModel.navigationStackCount == 0 {
                        contentViewModel.toggleIsBlogViewPresented()
                    } else {
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
    BlogView()
}

extension Color {
    static let primaryDarkModeLabelColor = Color.white
    static let secondaryDarkModeLabelColor = Color.init(red: 0.9, green: 0.9, blue: 0.9).opacity(0.8)
}

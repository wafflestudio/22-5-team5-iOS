//
//  BlogView.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct BlogView: View {
    @State var viewModel = BlogViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    Color.blue
                        .frame(height: 300)
                    
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
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
        } //toolbar
    }
}

#Preview {
    BlogView()
}

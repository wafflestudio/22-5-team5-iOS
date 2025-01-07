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
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    
                    BlogHeaderView()
                    
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                print("\(newValue) / \(oldValue)")
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    
                    
                    Color.clear
                        .frame(height: 3000)
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
                    dismiss()
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
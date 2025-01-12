//
//  PopularBlogPostSheetView.swift
//  Wastory
//
//  Created by 중워니 on 1/12/25.
//

import SwiftUI

struct PopularBlogPostSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel = PopularBlogPostSheetViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { geometry in
                        Color.clear
                            .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                                if abs(newValue - oldValue) > 200 {
                                    viewModel.setInitialScrollPosition(oldValue)
                                }
                                // 스크롤 오프셋이 네비게이션 바 아래로 들어가면 텍스트 숨김
                                viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
                            }
                    }
                    .frame(height: 0)
                    
                    // MARK: 화면 상단 구성 요소
                    HStack {
                        //Navbar title
                        Text("인기글")
                            .font(.system(size: 34, weight: .medium))
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            //
                        }) {
                            HStack(spacing: 0) {
                                Text("\(viewModel.getSortCriterion())  ")
                                
                                Image(systemName: "chevron.down")
                            }
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color.primaryLabelColor)
                        }
                    }
                    .padding(.trailing, 22)
                    
                    //MARK: PostList
                    LazyVStack(spacing: 0) {
                        ForEach(Array(viewModel.popularBlogPostItems.enumerated()), id: \.offset) { index, item in
                            FeedCell()
                            Divider()
                                .foregroundStyle(Color.secondaryLabelColor)
                        }
                    }
                } //VStack
            } //ScrollView
        } //VStack
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(Text(viewModel.getIsNavTitleHidden() ? "" : "인기글"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .light))
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
        }
        
    }
}

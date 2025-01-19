//
//  CategoryPostListView.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct CategoryPostListView: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.postViewModel) var viewModel
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            
            HStack(alignment: .center, spacing: 6) {
                Text("카테고리 (미선택 시 : 이 블로그)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.loadingCoralRed)
                
                Text("의 다른 글") // selected category로 설정
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                
                contentViewModel.openNavigationStackWithBlogButton(tempBlog()) {
                    Text("더보기")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                }
            }
            .padding(.horizontal, 20)
        
            
            Spacer()
                .frame(height: 5)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(viewModel.categoryPostListItems.enumerated()), id: \.offset) { index, item in
                    if index < 4 {
                        CategoryPostListCell()
                    }
                }
            }
        } //VStack
        .background(Color.white)
    }
}

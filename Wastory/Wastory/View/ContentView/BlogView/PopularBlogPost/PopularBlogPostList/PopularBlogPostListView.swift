//
//  PopularBlogPostListView.swift
//  Wastory
//
//  Created by 중워니 on 1/7/25.
//

import SwiftUI

struct PopularBlogPostListView: View {
    @Environment(\.blogViewModel) var viewModel
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 23)
            
            HStack(spacing: 0) {
                Text("인기글")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.primaryLabelColor)
                
                Spacer()
                
                Button(action: {
                    contentViewModel.navigateToPopularBlogPostSheet()
                }) {
                    Text("모두보기")
                        .font(.system(size: 14, weight: .light))
                        .foregroundStyle(Color.secondaryLabelColor)
                }
                
            }
            
            Spacer()
                .frame(height: 10)
            
            LazyVStack(spacing: 0) {
                ForEach(Array(viewModel.popularBlogPostItems[0..<3].enumerated()), id: \.offset) { index, item in
                    PopularBlogPostCell()
                    Divider()
                        .foregroundStyle(index == 2 ? Color.clear : Color.secondaryLabelColor)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.1), radius: 7)
        }
        .padding(.horizontal, 20)
    }
}
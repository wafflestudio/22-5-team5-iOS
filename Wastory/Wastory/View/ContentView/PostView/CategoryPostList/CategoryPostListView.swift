//
//  CategoryPostListView.swift
//  Wastory
//
//  Created by 중워니 on 1/8/25.
//

import SwiftUI

struct CategoryPostListView: View {
    @Environment(\.postViewModel) var viewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 30)
            
            Button(action: {
                
            }) {
                HStack(alignment: .center, spacing: 6) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 23, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                        .padding(.leading, 20)
                    
                    Text("분류 전체보기") // selected category로 설정
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.primaryLabelColor)
                    
                    Spacer()
                }
            }
            
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

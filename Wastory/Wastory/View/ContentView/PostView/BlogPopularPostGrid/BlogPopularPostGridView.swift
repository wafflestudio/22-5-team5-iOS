//
//  BlogPopularPostGridView.swift
//  Wastory
//
//  Created by 중워니 on 1/10/25.
//

import SwiftUI

struct BlogPopularPostGridView: View {
    
    @Environment(\.contentViewModel) var contentViewModel
    @Environment(\.postViewModel) var viewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 20)
            
            
            HStack(alignment: .center, spacing: 6) {
                Text("이 블로그의 인기글")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.primaryLabelColor)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            
            Spacer()
                .frame(height: 5)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.blogPopularPostGridItems.prefix(6), id: \.self) { item in
                    BlogPopularPostGridCell()
                }
            }
            .padding(.horizontal, 20)
            
            
            Spacer()
                .frame(height: 20)
        } //VStack
        .background(Color.white)
    }
}

//
//  FeedView.swift
//  Wastory
//
//  Created by 중워니 on 12/25/24.
//

import SwiftUI

//"피드" View에 구독 중인 블로그의 최신 글을 표시
struct FeedView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                
            }
        }
        .navigationTitle(Text("피드"))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    FeedView()
}

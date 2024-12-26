//
//  FeedView.swift
//  Wastory
//
//  Created by 중워니 on 12/25/24.
//

import SwiftUI

//"피드" View에 구독 중인 블로그의 최신 글을 표시
struct FeedView: View {
    
    @State var subscribingCount: Int = 0 // 구독중 count
    @State var subscriberCount:  Int = 0 // 구독자 count
    
    //임시 데이터 배열
    var items: [String] = ["아이템 1", "아이템 2", "아이템 3", "아이템 4", "아이템 5"]
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                
                // MARK: subCountTexts
                HStack {
                    Spacer()
                    
                    // 구독중
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("구독중")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                        
                        Text("\(subscribingCount)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.black)
                    }
                    .padding(.trailing, 12)
                    
                    // 구독자
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("구독자")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                        
                        Text("\(subscriberCount)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.black)
                    }
                }
                .offset(y: -50) // NavBar 위로 올라가도록 offset 조정
                .padding(.trailing, 22)
                .padding(.bottom, -50)
                
                //MARK: PostList
                LazyVStack(spacing: 0) {
                    ForEach(items, id: \.self) { _ in
                        FeedCell()
                        Divider()
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(Text("피드"))
        .navigationBarTitleDisplayMode(.large)
//        .toolbarBackground(Color.blue, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)       // NavBar size 테스트 용도
                
        
    }
}

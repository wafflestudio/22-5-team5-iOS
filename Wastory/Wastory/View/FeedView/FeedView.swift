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
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                
                //MARK: subCountTexts
                HStack {
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("구독중")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                        
                        Text("\(subscribingCount)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.black)
                    }
                    .padding(.trailing, 12)
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("구독자")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                        
                        Text("\(subscriberCount)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.black)
                    }
                }
                .offset(y: -50)
                .padding(.trailing, 22)
                
                
            }
        }
        //MARK: NavBar
        .navigationTitle(Text("피드"))
        .navigationBarTitleDisplayMode(.large)
//        .toolbarBackground(Color.blue, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)       // NavBar size 테스트 용도
                
        
    }
}

//
//  FeedView.swift
//  Wastory
//
//  Created by 중워니 on 12/25/24.
//

import SwiftUI

//"피드" View에 구독 중인 블로그의 최신 글을 표시
struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    @State var subscribingCount: Int = 0 // 구독중 count
    @State var subscriberCount:  Int = 0 // 구독자 count
    
    //임시 데이터 배열
    var items: [String] = ["아이템 1", "아이템 2", "아이템 3", "아이템 4", "아이템 5"]
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                            // 스크롤 오프셋이 네비게이션 바 아래로 들어가면 텍스트 숨김
                            viewModel.changeIsNavTitleHidden(by: newValue)
                        }
                }
                .frame(height: 0)
                
                // MARK: 화면 상단 구성 요소
                HStack {
                    //Navbar title
                    Text("피드")
                        .font(.system(size: 34, weight: .medium))
                        .padding(.leading)
                    
                    Spacer()
                    
                    // 구독중
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("구독중")
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                        
                        Text("\(subscribingCount)")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.black)
                    }
                    .padding(.trailing, 12)
                    
                    // 구독자
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("구독자")
                            .font(.system(size: 13, weight: .light))
                            .foregroundStyle(Color.gray)
                            .padding(.bottom, 4)
                        
                        Text("\(subscriberCount)")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.black)
                    }
                }
                .padding(.trailing, 22)
                
                //MARK: PostList
                LazyVStack(spacing: 0) {
                    ForEach(items, id: \.self) { _ in
                        FeedCell()
                        Divider()
                            .foregroundStyle(Color.secondaryLabelColor)
                    }
                }
            }
        }
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(Text(viewModel.getIsNavTitleHidden() ? "피드" : ""))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    
                } label: {
                    Text(Image(systemName: "magnifyingglass"))
                }
            } // navbar 사이즈 설정을 위한 임의 버튼입니다.
        }
                
        
    }
}

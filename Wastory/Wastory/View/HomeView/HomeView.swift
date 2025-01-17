//
//  HomeView.swift
//  Wastory
//
//  Created by 중워니 on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel = HomeViewModel()
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // MARK: 오늘의 와스토리 PageTabView
                TodaysWastoryPageTabView(viewModel: viewModel)
                
                // MARK: 오늘의 와스토리 ListView
                TodaysWastoryListView(viewModel: viewModel)
                
                
                Spacer()
                    .frame(height: 10)
                
                
                // MARK: 카테고리 인기글
                CategoryPopularPostView(viewModel: viewModel)
                
                
                Spacer()
                    .frame(height: 10)
                
                
                // MARK: Focus Post List - J의 주말 계획 & 오후에는 커피 한 잔
                FocusPostListView(viewModel: viewModel)
                
                
                // MARK: end
                HStack {
                    Text("와스토리는 team5에서")
                    Image(systemName: "clock")
                    Text("을 넣어 만듭니다.")
                        .padding(.leading, -5)
                }
                .font(.system(size: 14, weight: .light))
                .foregroundStyle(Color.secondaryLabelColor)
                .padding(.vertical, 50)
                
            } //VStack
            .background(Color.backgourndSpaceColor)
        } //ScrollView
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundStyle(Color.primaryLabelColor)
                        .frame(width: 48, height: 2)
                        .offset(x: 13, y: 4)
                    
                    Text("wastory")
                        .foregroundStyle(Color.primaryLabelColor)
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding(.horizontal, 5)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    
                } label: {
                    Text(Image(systemName: "magnifyingglass"))
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    //
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.mainWBackgroundGray)
                            .frame(width: 36, height: 36)
                        VStack(spacing: 2) {
                            HStack(spacing: 4) {
                                MainWCircleUnit()
                                MainWCircleUnit()
                                MainWCircleUnit()
                            }
                            HStack(spacing: 4) {
                                MainWCircleUnit()
                                MainWCircleUnit()
                                MainWCircleUnit()
                            }
                            HStack(spacing: 4) {
                                MainWCircleUnit()
                                MainWCircleUnit()
                            }
                        }
                    }
                }
                .padding(.trailing, 10)
            }
        } //toolbar
        
    }
    
    
}


#Preview {
    HomeView()
}

struct MainWCircleUnit: View {
    var body: some View {
        Circle()
            .fill(Color.mainWCircleGray)
            .frame(width: 4.2, height: 4.2)
    }
}

extension Color {
    static let mainWBackgroundGray: Color = .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)  // 메인 네비게이션 바 W 버튼 배경색
    static let mainWCircleGray: Color = .init(red: 245 / 255, green: 245 / 255, blue: 245 / 255)  // 메인 네비게이션 바 W 버튼 유닛 색
}

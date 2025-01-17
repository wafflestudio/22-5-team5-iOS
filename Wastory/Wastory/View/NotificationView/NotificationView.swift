//
//  NotificationView.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//

import SwiftUI

struct NotificationView: View {
    @Bindable var viewModel: NotificationViewModel
    @Bindable var mainTabViewModel: MainTabViewModel
    
    //임시 데이터 배열
    var items: [String] = ["아이템 1", "아이템 2", "아이템 3", "아이템 4", "아이템 5"]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
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
                        Text("알림")
                            .font(.system(size: 34, weight: .medium))
                            .padding(.leading)
                        
                        Spacer()
                        
                        // 알림 종류 선택 button
                        Button(action: {
                            mainTabViewModel.toggleIsNotificationTypeSheetPresent()
                        }) {
                            HStack(spacing: 0) {
                                Text("\(viewModel.getNotificationType())  ")
                                
                                Image(systemName: "chevron.down")
                            }
                            .font(.system(size: 16, weight: .light))
                            .foregroundStyle(Color.primaryLabelColor)
                        }
                        
                    }
                    .padding(.trailing, 22)
                    
                    //MARK: NotificationList
                    LazyVStack(spacing: 0) {
                        ForEach(items, id: \.self) { _ in
                            NotificationCell()
                            Divider()
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
            }
        }
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(Text(viewModel.getIsNavTitleHidden() ? "알림" : ""))
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
    }
    
    
}

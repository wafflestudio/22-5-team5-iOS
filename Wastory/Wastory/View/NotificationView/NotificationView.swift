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
    var body: some View {
        VStack(spacing: 0) {
            //MARK: NavBar
            VStack(spacing: 0) {
                ZStack {
                    if !viewModel.getIsNavTitleHidden() {
                        HStack(spacing: 0) {
                            Spacer()
                            
                            Text("알림")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(Color.primaryLabelColor)
                            
                            Spacer()
                        }
                    }
                    
                    
                    // 공통버튼들
                    mainTabToolBarTrailingButtons(mainTabViewModel: mainTabViewModel)
                }
                .padding(.horizontal, 20)
                .frame(height: 44)
                
                if viewModel.getIsScrolled() {
                    Divider()
                        .foregroundStyle(Color.secondaryLabelColor)
                        .frame(height: 1)
                        .offset(y: -1)
                }
            }
            
            ScrollView {
                GeometryReader { geometry in
                    Color.clear
                        .onChange(of: geometry.frame(in: .global).minY) { newValue, oldValue in
                            viewModel.changeIsNavTitleHidden(by: newValue, oldValue)
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
                            Text(viewModel.notificationTypes[viewModel.notificationType] ?? "")
                            
                            Image(systemName: "chevron.down")
                        }
                        .font(.system(size: 16, weight: .light))
                        .foregroundStyle(Color.primaryLabelColor)
                    }
                    
                }
                .padding(.trailing, 22)
                
                //MARK: NotificationList
                LazyVStack(spacing: 0) {
                    ForEach(Array(viewModel.notifications.enumerated()), id: \.offset) { index, notification in
                        NotificationCell(notification: notification)
                        Divider()
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
        
        
    }
}

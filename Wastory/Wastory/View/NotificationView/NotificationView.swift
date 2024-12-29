//
//  NotificationView.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//

import SwiftUI

struct NotificationView: View {
    @State private var viewModel = NotificationViewModel()
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                
                // MARK: subCountTexts
                HStack {
                    Spacer()
//                    Text("\(viewModel.isTypeSheetPresent)")
                    // 알림 종류 선택
                    Button(action: {
                        viewModel.toggleIsTypeSheetPresent()
                    }) {
                        HStack(spacing: 0) {
                            Text("\(viewModel.getNotificationType())  ")
                            
                            Image(systemName: "chevron.down")
                        }
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.primaryLabelColor)
                    }
                    .sheet(isPresented: $viewModel.isTypeSheetPresent) {
                        List(viewModel.notificationTypes, id: \.self) { type in
                            Button(action: {
                                viewModel.setNotificationType(to: type)
                                viewModel.toggleIsTypeSheetPresent()
                            }) {
                                Text("\(type)")
                            }
                        }
                    }
                    
                }
                .offset(y: -30) // NavBar 위로 올라가도록 offset 조정
                .padding(.trailing, 22)
                .padding(.bottom, -50)
                
                //MARK: NotificationList
                
            }
        }
        // MARK: NavBar
        // TODO: rightTabButton - 검색버튼과 본인계정버튼은 4개의 TabView에 공통 적용이므로 추후 제작
        .navigationTitle(Text("알림"))
        .navigationBarTitleDisplayMode(.large)

        //        .toolbarBackground(Color.blue, for: .navigationBar)
        //        .toolbarBackground(.visible, for: .navigationBar)       // NavBar size 테스트 용도
    }
}

extension Color {
    static let primaryLabelColor: Color = .black
}

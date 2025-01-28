//
//  TypeSheet.swift
//  Wastory
//
//  Created by 중워니 on 12/31/24.
//

import SwiftUI

struct NotificationTypeSheet: View {
    @Bindable var viewModel: NotificationViewModel
    @Bindable var mainTabViewModel: MainTabViewModel
    
    var body: some View {
        ZStack {
            //MARK: Background Dimming
            (mainTabViewModel.isNotificationTypeSheetPresent ? Color.sheetOuterBackgroundColor : Color.clear)
                .frame(maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
                .onTapGesture {
                    mainTabViewModel.toggleIsNotificationTypeSheetPresent()
                }
            
            //MARK: NotificationTypeSheet List
            VStack {
                Spacer()
                if mainTabViewModel.isNotificationTypeSheetPresent {
                    let typeSheetTopSpace = viewModel.typeSheetTopSpace
                    let typeSheetRowHeight = viewModel.typeSheetRowHeight
                    let typeSheetBottomSpace = viewModel.typeSheetBottomSpace
                    let typeSheetHeight = typeSheetTopSpace + typeSheetBottomSpace + CGFloat(viewModel.notificationTypes.count) * typeSheetRowHeight
                    
                    ZStack {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: typeSheetTopSpace)
                            
                            ForEach(0...viewModel.notificationTypes.count - 1, id: \.self) { index in
                                NotificationTypeButton(for: index, isLast: index == viewModel.notificationTypes.count - 1, rowHeight: typeSheetRowHeight)
                            }
                            
                            Spacer()
                                .frame(height: typeSheetBottomSpace)
                        }
                        .frame(height: typeSheetHeight)
                        .background(Color.white)
                        .cornerRadius(20)
                        
                    }
                    .background(Color.clear)
                    .transition(.move(edge: .bottom)) // 아래에서 올라오는 애니메이션
                    .animation(.easeInOut, value: mainTabViewModel.isNotificationTypeSheetPresent)
                    
                }
            }
            
        }
        .ignoresSafeArea()
    }
    
    //MARK: NotificationTypeSheet Row(Button)
    @ViewBuilder func NotificationTypeButton(for type: Int, isLast: Bool, rowHeight: CGFloat) -> some View {
        Button(action: {
            viewModel.setNotificationType(to: type)
            mainTabViewModel.toggleIsNotificationTypeSheetPresent()
        }) {
            HStack(spacing: 0) {
                Text(viewModel.notificationTypes[type] ?? "")
                    .font(.system(size: 17, weight: viewModel.isCurrentType(is: type) ? .semibold : .light))
                    .foregroundStyle(Color.primaryLabelColor)
                    .padding()
                
                Spacer()
                
                Image(systemName: "checkmark.circle.fill")
                    .tint(viewModel.isCurrentType(is: type) ? Color.primaryLabelColor : Color.clear)
                    .font(.system(size: 20, weight: .regular))
                    .padding(.trailing, 15)
            }
        }
        .frame(height: rowHeight)
        .frame(maxWidth: .infinity)
        
        if !isLast {
            Divider()
                .foregroundStyle(Color.secondaryLabelColor)
        }
    }
}

//
//  TypeSheet.swift
//  Wastory
//
//  Created by 중워니 on 12/31/24.
//

import SwiftUI

struct NotificationTypeSheet: View {
    @Binding var viewModel: NotificationViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 15)
                
                ForEach(viewModel.notificationTypes, id: \.self) { type in
                    Button(action: {
                        viewModel.setNotificationType(to: type)
                        viewModel.toggleIsTypeSheetPresent()
                    }) {
                        HStack(spacing: 0) {
                            Text("\(type)")
                                .font(.system(size: 17, weight: viewModel.isCurrentType(is: type) ? .semibold : .light))
                                .padding()
                            
                            
                            Spacer()
                            
                            Image(systemName: "checkmark.circle.fill")
                                .tint(viewModel.isCurrentType(is: type) ? Color.primaryLabelColor : Color.clear)
                                .font(.system(size: 20, weight: .regular))
                                .padding(.trailing, 15)
                        }
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                        .foregroundStyle(Color.secondaryLabelColor)
                }
            }
            .frame(height: 60 * 6 + 15)
            .background(Color.white)
            .cornerRadius(20)
            
        }
        .background(Color.sheetOuterBackgroundColor)
    }
}

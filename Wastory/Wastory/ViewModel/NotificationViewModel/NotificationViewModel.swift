//
//  NotificationViewModel.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//

import SwiftUI
import Observation

@Observable final class NotificationViewModel {
    let notificationTypes = ["전체 알림", "새글 알림", "구독 알림", "댓글 알림", "방명록 알림", "챌린지 알림"]
    var notificationType: String = "전체 알림"
    
    var isTypeSheetPresent = false
    var typeSheetHeight: CGFloat = 0
    
    private var isNavTitleHidden = false
    
    //MARK: isTypeSheetPresent
    func toggleIsTypeSheetPresent() {
        withAnimation(.easeInOut) {
            isTypeSheetPresent.toggle()
        }
    }
    
    func getIsTypeSheetPresent() -> Bool {
        isTypeSheetPresent
    }
    
    
    //MARK: NotificationType
    func getNotificationType() -> String {
        notificationType
    }
    
    
    func setNotificationType(to type: String) {
        notificationType = type
    }
    
    func isCurrentType(is type: String) -> Bool {
        type == notificationType
    }
    
    func isLastType(_ index: Int) -> Bool {
        index == notificationTypes.count - 1
    }
    
    //MARK: isNavTitleHidden
    func changeIsNavTitleHidden(by newValue: CGFloat) {
        if newValue <= 60 {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else {
            if (isNavTitleHidden) {
                isNavTitleHidden = false
            }
        }
    }
    
    func getIsNavTitleHidden() -> Bool {
        isNavTitleHidden
    }
}

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
    
    var typeSheetHeight: CGFloat = 0
    
    private var isNavTitleHidden = false
    
    
    //NotificationTypeSheet Layout
    var typeSheetTopSpace: CGFloat = 15
    var typeSheetRowHeight: CGFloat = 60
    var typeSheetBottomSpace: CGFloat = 30
    
    
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
    
    func isLastType(index i: Int) -> Bool {
        i == notificationTypes.count - 1
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

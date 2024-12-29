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
    
    
    func toggleIsTypeSheetPresent() {
        isTypeSheetPresent.toggle()
    }
    
    func getIsTypeSheetPresent() -> Bool {
        isTypeSheetPresent
    }
    
    func getNotificationType() -> String {
        notificationType
    }
    
    func setNotificationType(to type: String) {
        notificationType = type
    }
}

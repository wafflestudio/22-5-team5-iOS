//
//  NotificationViewModel.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//

import SwiftUI
import Observation

@Observable final class NotificationViewModel {
    //NavBar Controller
    private var isNavTitleHidden: Bool = true
    
    private var isScrolled: Bool = false
    
    private var initialScrollPosition: CGFloat = 0
    
    private var isInitialScrollPositionSet: Bool = false
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
        print(initialScrollPosition)
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if !isInitialScrollPositionSet {
            setInitialScrollPosition(oldValue)
            isInitialScrollPositionSet = true
        }
        
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= initialScrollPosition - 44 {
            if (isNavTitleHidden) {
                isNavTitleHidden = false
            }
        } else {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        }
        
        if newValue < initialScrollPosition {
            if (!isScrolled) {
                isScrolled = true
            }
        } else {
            if (isScrolled) {
                isScrolled = false
            }
        }
    }
    
    func getIsNavTitleHidden() -> Bool {
        isNavTitleHidden
    }
    
    func getIsScrolled() -> Bool {
        isScrolled
    }
    
    //notification
    let notificationTypes = ["전체 알림", "새글 알림", "구독 알림", "댓글 알림", "방명록 알림", "챌린지 알림"]
    var notificationType: String = "전체 알림"
    
    var typeSheetHeight: CGFloat = 0
    
    
    
    //NotificationTypeSheet Layout
    let typeSheetTopSpace: CGFloat = 15
    let typeSheetRowHeight: CGFloat = 60
    let typeSheetBottomSpace: CGFloat = 30
    
    
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
    
    
}

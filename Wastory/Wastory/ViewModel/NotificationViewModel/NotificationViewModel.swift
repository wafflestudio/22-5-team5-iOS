//
//  NotificationViewModel.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//

import SwiftUI
import Observation

@MainActor
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
    let notificationTypes: [Int: String] = [
        0: "전체 알림",
        1: "새글 알림",
        2: "구독 알림",
        3: "댓글 알림",
        4: "방명록 알림",
        5: "쪽지 알림"
    ]
    var notificationType: Int = 0
    
    var typeSheetHeight: CGFloat = 0
    
    
    
    //NotificationTypeSheet Layout
    let typeSheetTopSpace: CGFloat = 15
    let typeSheetRowHeight: CGFloat = 60
    let typeSheetBottomSpace: CGFloat = 30
    
    
    //MARK: NotificationType
    func getNotificationType() -> Int {
        notificationType
    }
    
    
    func setNotificationType(to type: Int) {
        notificationType = type
    }
    
    func isCurrentType(is type: Int) -> Bool {
        type == notificationType
    }
    
    func isLastType(index i: Int) -> Bool {
        i == notificationTypes.count - 1
    }
    
    //navigation
    var isNavigation1Active: Bool = false
    var isNavigation2Active: Bool = false
    var isNavigation3Active: Bool = false
    var isNavigation4Active: Bool = false
    var isNavigation5Active: Bool = false
    
    func toggleIsNavigationActive(_ type: Int) {
        switch type {
        case 1:
            isNavigation1Active.toggle()
        case 2:
            isNavigation2Active.toggle()
        case 3:
            isNavigation3Active.toggle()
        case 4:
            isNavigation4Active.toggle()
        case 5:
            isNavigation5Active.toggle()
        default:
            _ = ""
        }
    }
    
    //pagination
    var page = 1
    var isPageEnded: Bool = false
    
    func resetPage() {
        page = 1
        isPageEnded = false
        notifications = []
    }
    
    //Network
    var notifications: [Noti] = [Noti.default1Notification, Noti.default2Notification, Noti.default3Notification, Noti.default4Notification]
    
    var targetNotification: Noti? = nil
    
    func setTargetNotification(_ notification: Noti?) {
        targetNotification = notification
    }
    
    
    var isAlertPresent: Bool = false
    
    func toggleIsAlertPresent() {
        isAlertPresent.toggle()
    }
    
    func getNotifications() async {
        if !isPageEnded {
            do {
                let response = try await NetworkRepository.shared.getNotifications(page: page, type: (notificationType == 0 ? nil : notificationType))
                
                //comments 저장
                if self.page == 1 {
                    notifications = response
                } else {
                    notifications.append(contentsOf: response)
                }
                
                //pagination
                if !response.isEmpty {
                    self.page += 1
                } else {
                    self.isPageEnded = true
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func patchNotificationRead() async {
        if !targetNotification!.checked {
            do {
                let _ = try await NetworkRepository.shared.patchNotification(notificationID: targetNotification!.id)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteNotificationRead() async {
        do {
            let _ = try await NetworkRepository.shared.deleteNotification(notificationID: targetNotification!.id)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}

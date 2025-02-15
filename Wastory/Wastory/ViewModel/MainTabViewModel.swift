//
//  MainTabViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/1/25.
//

import SwiftUI
import Observation

@MainActor
@Observable final class MainTabViewModel {
    var selectedTab: TabType = .home
    
    var isBlogSheetPresent: Bool = false
    
    var isArticleViewPresent: Bool = false
    
    var isNotificationTypeSheetPresent: Bool = false
    
    //MARK: selectedTab
    func setSelectedTab(to tab: TabType) {
        selectedTab = tab
    }
    
    //MARK: isBlogSheetPresent
    func toggleIsBlogSheetPresent() {
        withAnimation(.easeInOut) {
            isBlogSheetPresent.toggle()
        }
    }
    
    //MARK: isNotificationTypeSheetPresent
    func toggleIsNotificationTypeSheetPresent() {
        withAnimation(.easeInOut) {
            isNotificationTypeSheetPresent.toggle()
        }
    }
    
    func getIsNotificationTypeSheetPresent() -> Bool {
        isNotificationTypeSheetPresent
    }
    
    //MARK: isPostingViewPresent
    func toggleIsArticleViewPresent() {
        withAnimation(.easeInOut) {
            isArticleViewPresent.toggle()
        }
    }
    
    
    
    //MARK: Notification Icon
    var isNotificationUnread: Bool = false
    
    var prevFirstNotificationID: Int = -1
    
    
    func setIsNotificationUnread() async {
        do {
            let response = try await NetworkRepository.shared.getNotifications(page: 1, type: nil)
            if response.isEmpty {
                isNotificationUnread = false
            } else {
                if prevFirstNotificationID == response.first!.id && !isNotificationUnread {
                    isNotificationUnread = false
                } else {
                    prevFirstNotificationID = response.first!.id
                    if let _ = response.first(where: { !$0.checked }) {
                        isNotificationUnread = true
                    }
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

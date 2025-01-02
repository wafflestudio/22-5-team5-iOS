//
//  MainTabViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/1/25.
//

import SwiftUI
import Observation

@Observable final class MainTabViewModel {
    var selectedTab: TabType = .home
    
    var isNotificationTypeSheetPresent: Bool = false
    
    
    //MARK: isNotificationTypeSheetPresent
    func toggleIsNotificationTypeSheetPresent() {
        withAnimation(.easeInOut) {
            isNotificationTypeSheetPresent.toggle()
        }
    }
    
    func getIsNotificationTypeSheetPresent() -> Bool {
        isNotificationTypeSheetPresent
    }
    
}

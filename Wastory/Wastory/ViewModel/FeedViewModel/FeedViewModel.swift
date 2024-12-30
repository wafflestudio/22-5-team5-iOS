//
//  SignInViewModel.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//



import SwiftUI
import Observation

@Observable final class FeedViewModel {
    private var isNavTitleHidden: Bool = false
    
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

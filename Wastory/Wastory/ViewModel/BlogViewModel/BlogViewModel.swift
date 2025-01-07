//
//  BlogViewModel.swift
//  Wastory
//
//  Created by 중워니 on 01/07/25.
//



import SwiftUI
import Observation

@Observable final class BlogViewModel {
    private var isNavTitleHidden: Bool = true
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == 0 {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= -100 {
            if (isNavTitleHidden) {
                isNavTitleHidden = false
            }
        } else {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        }
    }
    
    func getIsNavTitleHidden() -> Bool {
        isNavTitleHidden
    }
    
}

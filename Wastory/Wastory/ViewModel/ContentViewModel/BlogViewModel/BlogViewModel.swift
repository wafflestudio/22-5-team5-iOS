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
    
    private var initialScrollPosition: CGFloat = 0
    
    var isNavigationToNextPost: Bool = false
    
    
    
    
    var popularBlogPostItems: [String] = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8", "item 9", "item 10"]
    
    var blogPostListItems: [String] = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8", "item 9", "item 10"]
    
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= 100 {
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


// Environment Key 정의
private struct BlogViewModelKey: EnvironmentKey {
    static let defaultValue = BlogViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var blogViewModel: BlogViewModel {
        get { self[BlogViewModelKey.self] }
        set { self[BlogViewModelKey.self] = newValue }
    }
}
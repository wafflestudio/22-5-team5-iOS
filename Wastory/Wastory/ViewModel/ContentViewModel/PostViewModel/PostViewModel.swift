//
//  PostViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//



import SwiftUI
import Observation

@Observable final class PostViewModel {
    private var isNavTitleHidden: Bool = false
    
    private var initialScrollPosition: CGFloat = 0
    
    var categoryPostListItems: [String] = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]
    
    var blogPopularPostGridItems: [String] = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]
    
    
    //blogPopularPostGrid
    private var blogPopularPostGridCellWidth: CGFloat = 0
    
    func setBlogPopularPostGridCellWidth(_ size: CGFloat) {
        blogPopularPostGridCellWidth = size
    }
    
    func getBlogPopularPostGridCellWidth() -> CGFloat {
        blogPopularPostGridCellWidth
    }
    //
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = false
            }
        } else if newValue > 0 {
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
private struct PostViewModelKey: EnvironmentKey {
    static let defaultValue = PostViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var postViewModel: PostViewModel {
        get { self[PostViewModelKey.self] }
        set { self[PostViewModelKey.self] = newValue }
    }
}

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
    
    var isNavigationToNextPost: Bool = false
    
    var isNavigationToNextBlog: Bool = false
    
    
    
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

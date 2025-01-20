//
//  SignInViewModel.swift
//  Wastory
//
//  Created by 중워니 on 12/29/24.
//



import SwiftUI
import Observation

@Observable final class FeedViewModel {
    //NavBar Controller
    private var isNavTitleHidden: Bool = true
    
    private var isScrolled: Bool = false
    
    private var initialScrollPosition: CGFloat = 0
    
    private var isInitialScrollPositionSet: Bool = false
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
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
    
    //Network
    var posts: [Post] = []
    
}


// Environment Key 정의
private struct FeedViewModelKey: EnvironmentKey {
    static let defaultValue = FeedViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var feedViewModel: FeedViewModel {
        get { self[FeedViewModelKey.self] }
        set { self[FeedViewModelKey.self] = newValue }
    }
}

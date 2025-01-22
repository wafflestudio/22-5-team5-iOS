//
//  SubscribeBlogViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/22/25.
//


import SwiftUI
import Observation

@Observable final class SubscribeBlogViewModel {
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= initialScrollPosition - 53 {
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
    
    //ViewType
    var subscribeType: SubscribeType = .subscribing
    
    func initSubscribeType(_ type: SubscribeType) {
        subscribeType = type
    }
    
    func isSubscribing() -> Bool {
        subscribeType == .subscribing
    }
    
    
    //pagination
    var page = 1
    var isPageEnded: Bool = false
    
    func resetPage() {
        page = 1
    }
    
    //Network
    var blogs: [Blog] = [
        Blog(id: 1, blogName: "1번 블로그", addressName: "random", description: "블로그설명 주룩주룩", userID: 1),
        Blog(id: 2, blogName: "1번 블로그", addressName: "random", description: "블로그설명 주룩주룩", userID: 1),
        Blog(id: 3, blogName: "1번 블로그", addressName: "random", description: "블로그설명 주룩주룩", userID: 1)
    ]
    
    var totalCount: Int?
}


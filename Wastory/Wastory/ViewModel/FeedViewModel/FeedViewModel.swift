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
    
    //pagination
    var page = 1
    var isPageEnded: Bool = false
    
    func resetPage() {
        page = 1
        isPageEnded = false
        posts = []
    }
    
    //Network
    var posts: [Post] = []
    
    var subscriberCount: Int = 0
    var subscribingCount: Int = 0
    
    func getPosts() async {
        do {
            let response = try await NetworkRepository.shared.getArticlesOfSubscription(blogID: UserInfoRepository.shared.getBlogID(), page: self.page)
            
            if self.page == 1 {
                self.posts = response
            } else {
                self.posts.append(contentsOf: response)
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
    
    func getSubscriptionCounts() async {
        do {
            subscriberCount = try await NetworkRepository.shared.getMySubscriberBlogs(page: 1).totalCount
            subscribingCount = try await NetworkRepository.shared.getMySubscribingBlogs(page: 1).totalCount
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
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

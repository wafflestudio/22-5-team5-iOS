//
//  SubscribeBlogViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/22/25.
//


import SwiftUI
import Observation

@MainActor
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
        blogs = []
        isPageEnded = false
    }
    
    //Network
    var blogs: [Blog] = []
    
    var totalCount: Int?
    
    
    func getBlogs() async {
        if !isPageEnded {
            do {
                var response = BlogListDto.defaultBlogListDto
                if subscribeType == .subscribing {
                    response = try await NetworkRepository.shared.getMySubscribingBlogs(page: page)
                } else {
                    response = try await NetworkRepository.shared.getMySubscriberBlogs(page: page)
                }
                
                //blogs 저장
                if self.page == 1 {
                    blogs = response.blogs
                } else {
                    blogs.append(contentsOf: response.blogs)
                }
                
                totalCount = response.totalCount
                
                //pagination
                if !response.blogs.isEmpty {
                    self.page += 1
                } else {
                    self.isPageEnded = true
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}


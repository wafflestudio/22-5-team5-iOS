//
//  ContentViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI
import Observation

enum NavigationDestination: Hashable {
    case blog(Blog)
    case post(Post)
    case comment(Int)
    case popularBlogPostSheet
    case search(Int?, String?)
}

@Observable final class ContentViewModel {
    
    var isMainTabViewPresented: Bool = true
    
    var isBlogViewPresented: Bool = false
    
    var isPostViewPresented: Bool = false
    
    var isSearchViewPresented: Bool = false
    
    var isAnyViewPresented: Bool = false
    
    
    var navigationPath: [NavigationDestination] = []
    
    var navigationBlog = Blog(id: UUID(), userID: UUID(), blogName: "", mainImageURL: "", description: "")
    var navigationPost = Post(id: 0, blogID: 1, title: "", createdAt: Date(), commentCount: 5, likeCount: 5)
    var navigationSearchBlogID: Int?
        
    func navigateToBlog(_ blog: Blog) {
        navigationPath.append(.blog(blog))
    }
    
    func navigateToPost(_ post: Post) {
        navigationPath.append(.post(post))
    }
    
    func navigateToComment(postID: Int) {
        navigationPath.append(.comment(postID))
    }
    
    func navigateToPopularBlogPostSheet() {
        navigationPath.append(.popularBlogPostSheet)
    }
    
    func navigateToSearch(in blogID: Int? = nil, with prevSearchKeyword: String? = nil) {
        navigationPath.append(.search(blogID, prevSearchKeyword))
    }
    
    
    
    func updateIsAnyViewPresented() {
        withAnimation {
            isAnyViewPresented = isBlogViewPresented || isPostViewPresented || isSearchViewPresented
        }
    }
    
    func updateisMainTabViewPresented() {
        withAnimation {
            isMainTabViewPresented = !isAnyViewPresented
        }
    }
    
    func toggleIsBlogViewPresented() {
        isBlogViewPresented.toggle()
        updateIsAnyViewPresented()
        updateisMainTabViewPresented()
    }
    
    func toggleIsPostViewPresented() {
        isPostViewPresented.toggle()
        updateIsAnyViewPresented()
        updateisMainTabViewPresented()
    }
    
    func toggleIsSearchViewPresented() {
        isSearchViewPresented.toggle()
        updateIsAnyViewPresented()
        updateisMainTabViewPresented()
    }
    
    // Button 동작
    // Back Button
    func backButtonAction(dismiss: @escaping () -> Void) {
        dismiss()
    }
    
    func openNavigationStackWithBlogButton(_ buttonContent: @escaping () -> some View) -> some View { //TODO: 보여줄 Blog 정하기{
        Button(action: {
            // TODO: 해당 블로그 View로 이동
            if self.isAnyViewPresented {
                self.navigateToBlog(self.navigationBlog) //Post 받아와야함
            } else {
                self.toggleIsBlogViewPresented()
            }
        }) {
            buttonContent()
        }
    }
    
    func openNavigationStackWithPostButton() -> some View { //TODO: 보여줄 Post 정하기
        Button(action: {
            if self.isAnyViewPresented {
                self.navigateToPost(self.navigationPost) //Post 받아와야함
            } else {
                self.toggleIsPostViewPresented()
            }
        }) {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.clear)
        }
    }

}


// Environment Key 정의
private struct ContentViewModelKey: EnvironmentKey {
    static let defaultValue = ContentViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var contentViewModel: ContentViewModel {
        get { self[ContentViewModelKey.self] }
        set { self[ContentViewModelKey.self] = newValue }
    }
}

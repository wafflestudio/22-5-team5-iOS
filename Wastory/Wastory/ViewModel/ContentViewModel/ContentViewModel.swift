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
    
}

@Observable final class ContentViewModel {
    
    var isMainTabViewPresented: Bool = true
    
    var isBlogViewPresented: Bool = false
    
    var isPostViewPresented: Bool = false
    
    var isAnyViewPresented: Bool = false
    
    
    var navigationPath: [NavigationDestination] = []
    
    var navigationBlog = Blog(id: UUID(), userID: UUID(), blogName: "", mainImageURL: "", description: "")
    var navigationPost = Post(id: UUID(), blogID: UUID(), title: "Post Title", content: ["Post Content"], createdAt: Date(), mainImageUrl: "")
        
    func navigateToBlog(_ blog: Blog) {
        navigationPath.append(.blog(blog))
    }
    
    func navigateToPost(_ post: Post) {
        navigationPath.append(.post(post))
    }
    
    func navigateToPopularBlogPostSheet() {
        navigationPath.append(.popularBlogPostSheet)
    }
    
    
    
    func updateIsAnyViewPresented() {
        withAnimation {
            isAnyViewPresented = isBlogViewPresented || isPostViewPresented
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
    
    // Button 동작
    // Back Button
    func backButtonAction(dismiss: @escaping () -> Void) {
        if navigationPath.count == 0 {
            withAnimation {
                isBlogViewPresented = false
                isPostViewPresented = false
                isAnyViewPresented = false
                isMainTabViewPresented = false
            }
        } else {
            dismiss()
        }
    }
    
    func openNavigationStackWithBlogButton(_ buttonContent: @escaping () -> some View) -> some View { //TODO: 보여줄 Blog 정하기{
        Button(action: {
            // TODO: 해당 블로그 View로 이동
            self.toggleIsBlogViewPresented()
        }) {
            buttonContent()
        }
    }
    
    func openNavigationStackWithPostButton() -> some View { //TODO: 보여줄 Post 정하기
        Button(action: {
            self.toggleIsPostViewPresented()
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

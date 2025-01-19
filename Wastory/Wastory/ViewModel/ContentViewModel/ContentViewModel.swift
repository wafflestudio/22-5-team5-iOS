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
//
//    var isMainTabViewPresented: Bool = true
//    
//    var isBlogViewPresented: Bool = false
//    
//    var isPostViewPresented: Bool = false
//    
//    var isSearchViewPresented: Bool = false
//    
//    var isAnyViewPresented: Bool = false
//    
//    
//    var navigationPath: [NavigationDestination] = []
//    
//    var navigationBlog = Blog(id: UUID(), userID: UUID(), blogName: "", mainImageURL: "", description: "")
//    var navigationPost = Post(id: 0, blogID: 1, title: "", createdAt: Date(), commentCount: 5, likeCount: 5)
//    var navigationSearchBlogID: Int?
//        
//    func navigateToBlog(_ blog: Blog) {
//        navigationPath.append(.blog(blog))
//    }
//    
//    func navigateToPost(_ post: Post) {
//        navigationPath.append(.post(post))
//    }
//    
//    func navigateToComment(postID: Int) {
//        navigationPath.append(.comment(postID))
//    }
//    
//    func navigateToPopularBlogPostSheet() {
//        navigationPath.append(.popularBlogPostSheet)
//    }
//    
//    func navigateToSearch(in blogID: Int? = nil, with prevSearchKeyword: String? = nil) {
//        navigationPath.append(.search(blogID, prevSearchKeyword))
//    }
//    
//    
//    
//    func updateIsAnyViewPresented() {
//        withAnimation {
//            isAnyViewPresented = isBlogViewPresented || isPostViewPresented || isSearchViewPresented
//        }
//    }
//    
//    func updateisMainTabViewPresented() {
//        withAnimation {
//            isMainTabViewPresented = !isAnyViewPresented
//        }
//    }
//    
//    func toggleIsBlogViewPresented() {
//        isBlogViewPresented.toggle()
//        updateIsAnyViewPresented()
//        updateisMainTabViewPresented()
//    }
//    
//    func toggleIsPostViewPresented() {
//        isPostViewPresented.toggle()
//        updateIsAnyViewPresented()
//        updateisMainTabViewPresented()
//    }
//    
//    func toggleIsSearchViewPresented() {
//        isSearchViewPresented.toggle()
//        updateIsAnyViewPresented()
//        updateisMainTabViewPresented()
//    }
//
    
    // Button 동작
    // Back Button
    func backButtonAction(dismiss: @escaping () -> Void) {
        dismiss()
    }
    
    func openNavigationStackWithBlogButton(_ blog: Blog, _ buttonContent: @escaping () -> some View) -> some View { //TODO: 보여줄 Blog 정하기{
        NavigationLink(destination: BlogView(blog: blog)) {
            buttonContent()
        }
    }
    
    func openNavigationStackWithPostButton(_ post: Post) -> some View { //TODO: 보여줄 Post 정하기
        NavigationLink(destination: PostView(post: post)) {
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





extension View {
    func tempPost() -> Post {
        Post.init(id: 1, blogID: 1, title: "글 제목", createdAt: Date(), commentCount: 5, likeCount: 55)//
    }
    
    func tempBlog() -> Blog {
        Blog.init(id: UUID(), userID: UUID(), blogName: "블로그 이름", description: "블로그 설명\n설민석 아니고 설명 주절주절 길게 여러줄이 되나? 싶은 정도로\n\n설명")
    }
}

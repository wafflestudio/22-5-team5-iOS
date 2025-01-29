//
//  NavigationToContentButtons.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI

//@Observable final class ContentViewModel {
//    
//    // Button 동작
//    func navigateToBlogViewButton(_ blogID: Int, _ categoryID: Int? = nil, _ buttonContent: @escaping () -> some View) -> some View { //TODO: 보여줄 Blog 정하기{
//        NavigationLink(destination: BlogView(blogID: blogID, categoryID: categoryID ?? -1)) {
//            buttonContent()
//        }
//    }
//    
//    func navigateToPostViewButton(_ postID: Int, _ blogID: Int) -> some View { //TODO: 보여줄 Post 정하기
//        NavigationLink(destination: PostView(postID: postID, blogID: blogID)) {
//            Rectangle()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .foregroundStyle(Color.clear)
//        }
//    }
//
//    func navigateToSearchViewButton(blogID: Int? = nil, prevSearchKeyword: String? = nil, _ buttonContent: @escaping () -> some View) -> some View {
//        NavigationLink(destination: SearchView(blogID: blogID, prevSearchKeyword: prevSearchKeyword)) {
//            buttonContent()
//        }
//    }
//    
//}
//
//
//// Environment Key 정의
//private struct ContentViewModelKey: EnvironmentKey {
//    static let defaultValue = ContentViewModel()
//}
//
//// Environment Values 확장
//extension EnvironmentValues {
//    var contentViewModel: ContentViewModel {
//        get { self[ContentViewModelKey.self] }
//        set { self[ContentViewModelKey.self] = newValue }
//    }
//}


// BlogView로 네비게이션하는 버튼
struct NavigateToBlogViewButton<Content: View>: View {
    let blogID: Int
    let categoryID: Int?
    let buttonContent: Content

    init(_ blogID: Int, _ categoryID: Int? = nil, @ViewBuilder buttonContent: () -> Content) {
        self.blogID = blogID
        self.categoryID = categoryID
        self.buttonContent = buttonContent()
    }
    
    var body: some View {
        NavigationLink(destination: BlogView(blogID: blogID, categoryID: categoryID ?? -1)) {
            buttonContent
        }
    }
}

// PostView로 네비게이션하는 버튼
struct NavigateToPostViewButton: View {
    let postID: Int
    let blogID: Int
    var toComment: Bool
    
    init(_ postID: Int, _ blogID: Int, _ toComment: Bool? = false) {
        self.postID = postID
        self.blogID = blogID
        self.toComment = toComment ?? false
    }

    var body: some View {
        NavigationLink(destination: PostView(postID: postID, blogID: blogID, toComment: toComment)) {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.clear)
        }
    }
}

// SearchView로 네비게이션하는 버튼
struct NavigateToSearchViewButton<Content: View>: View {
    let blogID: Int?
    let prevSearchKeyword: String?
    let buttonContent: Content

    init(blogID: Int? = nil, prevSearchKeyword: String? = nil, @ViewBuilder buttonContent: () -> Content) {
        self.blogID = blogID
        self.prevSearchKeyword = prevSearchKeyword
        self.buttonContent = buttonContent()
    }

    var body: some View {
        NavigationLink(destination: SearchView(blogID: blogID, prevSearchKeyword: prevSearchKeyword)) {
            buttonContent
        }
    }
}

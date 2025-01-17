//
//  ContentViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI
import Observation

@Observable final class ContentViewModel {
    
    // Button 동작
    func navigateToBlogViewButton(_ blog: Blog, _ buttonContent: @escaping () -> some View) -> some View { //TODO: 보여줄 Blog 정하기{
        NavigationLink(destination: BlogView(blog: blog)) {
            buttonContent()
        }
    }
    
    func navigateToPostViewButton(_ post: Post) -> some View { //TODO: 보여줄 Post 정하기
        NavigationLink(destination: PostView(post: post)) {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(Color.clear)
        }
    }

    func navigateToSearchViewButton(blogID: Int? = nil, prevSearchKeyword: String? = nil, _ buttonContent: @escaping () -> some View) -> some View {
        NavigationLink(destination: SearchView(blogID: blogID, prevSearchKeyword: prevSearchKeyword)) {
            buttonContent()
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

//
//  ContentNavigationStack.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI

struct ContentNavigationStack: View {
    @Environment(\.contentViewModel) var contentViewModel
    @State var contentNavigationPath = NavigationPath()
    
    var body: some View {
        Group {
            if contentViewModel.isBlogViewPresented {
                BlogView(blog: contentViewModel.navigationOpenBlog)
                    .environment(\.contentViewModel, contentViewModel)
            } else if contentViewModel.isPostViewPresented {
                // 초기 PostView는 별도 처리 필요
            }
        }
        .navigationDestination(for: NavigationDestination.self) { destination in
            switch destination {
            case .blog(let blog):
                BlogView(blog: blog)
                    .environment(\.contentViewModel, contentViewModel)
            case .post(let post):
                PostView(post: post)
                    .environment(\.contentViewModel, contentViewModel)
            }
        }
    }
}

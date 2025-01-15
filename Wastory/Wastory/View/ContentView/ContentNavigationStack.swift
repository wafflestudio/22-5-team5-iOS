//
//  ContentNavigationStack.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

import SwiftUI

struct ContentNavigationStack: View {
    @Environment(\.contentViewModel) var contentViewModel
    
    var body: some View {
        NavigationStack(path: .init(
            get: { contentViewModel.navigationPath },
            set: { contentViewModel.navigationPath = $0 }
        )) {
            ZStack {
                if contentViewModel.isAnyViewPresented {
                    Color.white.ignoresSafeArea()
                    
                    Group {
                        if contentViewModel.isBlogViewPresented {
                            BlogView(blog: contentViewModel.navigationBlog)
                                .environment(\.contentViewModel, contentViewModel)
                        } else if contentViewModel.isPostViewPresented {
                            PostView(post: contentViewModel.navigationPost)
                                .environment(\.contentViewModel, contentViewModel)
                        }
                    }
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
                case .popularBlogPostSheet:
                    PopularBlogPostSheetView()
                }
            }
        }
        .opacity(contentViewModel.isAnyViewPresented ? 1 : 0)
        .offset(x: contentViewModel.isAnyViewPresented ? 0 : UIScreen.main.bounds.width)
        .animation(.easeInOut, value: contentViewModel.isAnyViewPresented)
    }
}

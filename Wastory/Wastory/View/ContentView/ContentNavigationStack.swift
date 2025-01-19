//
//  ContentNavigationStack.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//

//import SwiftUI
//
//struct ContentNavigationStack: View {
//    @Environment(\.contentViewModel) var contentViewModel
//    
//    var body: some View {
//        NavigationStack(path: .init(
//            get: { contentViewModel.navigationPath },
//            set: { contentViewModel.navigationPath = $0 }
//        )) {
//            ZStack {
//                if contentViewModel.isAnyViewPresented {
//                    Color.white.ignoresSafeArea()
//                    
//                    Group {
//                        if contentViewModel.isBlogViewPresented {
//                            BlogView(blog: contentViewModel.navigationBlog)
//                        } else if contentViewModel.isPostViewPresented {
//                            PostView(post: contentViewModel.navigationPost)
//                        } else if contentViewModel.isSearchViewPresented  {
//                            SearchView(blogID: nil, prevSearchKeyword: nil)
//                        }
//                    }
//                    .environment(\.contentViewModel, contentViewModel)
//                }
//            }
//            .navigationDestination(for: NavigationDestination.self) { destination in
//                switch destination {
//                case .blog(let blog):
//                    BlogView(blog: blog)
//                case .post(let post):
//                    PostView(post: post)
//                case .comment(let postID):
//                    CommentView(postID: postID)
//                case .popularBlogPostSheet:
//                    PopularBlogPostSheetView()
//                case .search(let blogID, let prevSearchKeyword):
//                    SearchView(blogID: blogID, prevSearchKeyword: prevSearchKeyword)
//                }
//            }
//        }
//        .opacity(contentViewModel.isAnyViewPresented ? 1 : 0)
//        .offset(x: contentViewModel.isAnyViewPresented ? 0 : UIScreen.main.bounds.width)
//        .animation(.easeInOut, value: contentViewModel.isAnyViewPresented)
//    }
//}

//
//  PostViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//



import SwiftUI
import Observation

@Observable final class PostViewModel {
    var post: Post?
    var blog: Blog?
    
    func initContent(_ post: Post, _ blog: Blog) {
        self.post = post
        self.blog = blog
    }
    
    
    
    private var isNavTitleHidden: Bool = false
    
    private var initialScrollPosition: CGFloat = 0
    
    
    //blogPopularPostGrid
    private var blogPopularPostGridCellWidth: CGFloat = 0
    
    func setBlogPopularPostGridCellWidth(_ size: CGFloat) {
        blogPopularPostGridCellWidth = size
    }
    
    func getBlogPopularPostGridCellWidth() -> CGFloat {
        blogPopularPostGridCellWidth
    }
    //
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = false
            }
        } else if newValue > initialScrollPosition {
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
    
    //Network
    var popularBlogPosts: [Post] = []
    
    var categoryBlogPosts: [Post] = []
    
        // - 블로그 내 인기글List views 순으로 get하기
    func getPopularBlogPosts() async {
        do {
            popularBlogPosts = try await NetworkRepository.shared.getTopArticlesInBlog(blogID: self.blog!.id, sortBy: PopularPostSortedType.views.api)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
        // - 블로그 내 같은 카테고리글List get
    func getPostsInBlogInCategory() async {
        if post!.categoryID == nil {
            do {
            categoryBlogPosts = try await NetworkRepository.shared.getArticlesInBlog(blogID: blog!.id, page: 1)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            do {
                categoryBlogPosts = try await NetworkRepository.shared.getArticlesInBlogInCategory(blogID: blog!.id, categoryID: post!.categoryID!, page: 1)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

// Environment Key 정의
private struct PostViewModelKey: EnvironmentKey {
    static let defaultValue = PostViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var postViewModel: PostViewModel {
        get { self[PostViewModelKey.self] }
        set { self[PostViewModelKey.self] = newValue }
    }
}

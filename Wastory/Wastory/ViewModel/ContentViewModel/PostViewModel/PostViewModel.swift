//
//  PostViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//



import SwiftUI
import Observation

@Observable final class PostViewModel {
    var post: Post = Post.defaultPost
    var blog: Blog = Blog.defaultBlog
    
    
    
    
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
    
    var isLiked: Bool = false
    
    var categoryName: String = "카테고리 get이 필요합니다"
    
    
    func initContent(_ postID: Int, _ blogID: Int) async {
        do {
            self.post = try await NetworkRepository.shared.getArticle(postID: postID)
            self.blog = try await NetworkRepository.shared.getBlogByID(blogID: blogID)
        } catch {
            print("Error: \(error.localizedDescription)")
            
        }
    }
    
    
    
    func deleteSelfPost(at List: inout [Post]) {
        for (index, item) in List.enumerated() {
            if item == self.post {
                List.remove(at: index)
            }
        }
    }
    
    
        // - 블로그 내 인기글List views 순으로 get하기
    func getPopularBlogPosts() async {
        do {
            popularBlogPosts = try await NetworkRepository.shared.getTopArticlesInBlog(blogID: self.blog.id, sortBy: PopularPostSortedType.views.api)
            deleteSelfPost(at: &popularBlogPosts)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
        // - 블로그 내 같은 카테고리글List get
    func getPostsInBlogInCategory() async {
        if post.categoryID == nil {
            do {
            categoryBlogPosts = try await NetworkRepository.shared.getArticlesInBlog(blogID: blog.id, page: 1)
            deleteSelfPost(at: &categoryBlogPosts)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        } else {
            do {
                categoryBlogPosts = try await NetworkRepository.shared.getArticlesInBlogInCategory(blogID: blog.id, categoryID: post.categoryID!, page: 1)
                deleteSelfPost(at: &categoryBlogPosts)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
        // - 유저가 해당 글을 좋아요 했는지 저장
    func getIsLiked() async {
        do {
            let response = try await NetworkRepository.shared.getIsLiked(postID: post.id)
            isLiked = response
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
        // - 좋아요 기능
    func createLike() async {
        do {
            try await NetworkRepository.shared.postLike(postID: post.id)
            isLiked = true
            post.likeCount += 1
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
        // - 좋아요 취소 기능
    func deleteLike() async {
        do {
            try await NetworkRepository.shared.deleteLike(postID: post.id)
            isLiked = false
            post.likeCount -= 1
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
        // - 좋아요 버튼 액션
    func likeButtonAction() async {
        if isLiked {
            await deleteLike()
        } else {
            await createLike()
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

//
//  PostViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/9/25.
//



import SwiftUI
import Observation
import RichTextKit

@MainActor
@Observable final class PostViewModel {
    var post: Post = Post.defaultPost
    var blog: Blog = Blog.defaultBlog
    
    
    
    var showComments = false
    
    
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
    
    var categoryName: String = ""
    
    
    func initContent(_ postID: Int, _ blogID: Int) async {
        do {
            self.post = try await NetworkRepository.shared.getArticle(postID: postID)
            self.blog = try await NetworkRepository.shared.getBlogByID(blogID: blogID)
            self.categoryName = try await NetworkRepository.shared.getCategory(categoryID: post.categoryID!).categoryName
        } catch {
            print("Error: \(error.localizedDescription)")
            
        }
    }
    
    // MARK: - Rendering Content
    var text = NSAttributedString()
    var context = RichTextContext()
    var textHeight: CGFloat = 0
    var isTextLoaded: Bool = false
    
    func DataTotext(_ data: String) -> NSAttributedString? {
        if let text = Data(base64Encoded: data) {
            do {
                return try NSAttributedString(data: text, format: .archivedData)
            } catch {
                print("Failed to load NSAttributedString: \(error)")
            }
        }
        return nil
    }
    
    func loadText() async {
        if let content = post.content {
            if let loadedText = RichTextHandler.DataTotext(content) {
                let restoredText = await RichTextImageHandler.restoreImage(loadedText)
                text = restoredText
                /*
                textHeight = text.boundingRect(
                    with: CGSize(width: UIScreen.main.bounds.width - 40, height: .greatestFiniteMagnitude),
                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                    context: nil).height + 30*/
                textHeight = calculateHeight(text: text, screenWidth: UIScreen.main.bounds.width - 40) + 30
                print("width: ", UIScreen.main.bounds.width - 40)
                print("height: ", textHeight)
                isTextLoaded = true
            }
            else {
                print("Error: Failed to load text data")
            }
        }
    }
    
    func calculateHeight(text: NSAttributedString, screenWidth: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        text.enumerateAttribute(.attachment, in: NSRange(location: 0, length: text.length)) { value, range, _ in
            if let attachment = value as? NSTextAttachment,
               let image = attachment.image {
                let imageAspectRatio = image.size.height / image.size.width
                height += imageAspectRatio * screenWidth
            }
        }
        
        let mutableAttrString = NSMutableAttributedString(attributedString: text)
        let fullRange = NSRange(location: 0, length: mutableAttrString.length)
        mutableAttrString.enumerateAttribute(.attachment, in: fullRange) { value, range, _ in
            if value != nil {
                mutableAttrString.replaceCharacters(in: range, with: "")
            }
        }
        
        height += mutableAttrString.boundingRect(
            with: CGSize(width: screenWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil).height
        
        return ceil(height)
    }
    
    
    func deleteSelfPost(at List: inout [Post]) {
        for (index, item) in List.enumerated() {
            if item.id == self.post.id {
                List.remove(at: index)
                break
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
        if post.categoryID == nil || post.categoryID == 0 {
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
//
//// Environment Key 정의
//private struct PostViewModelKey: EnvironmentKey {
//    static let defaultValue = PostViewModel()
//}
//
//// Environment Values 확장
//extension EnvironmentValues {
//    var postViewModel: PostViewModel {
//        get { self[PostViewModelKey.self] }
//        set { self[PostViewModelKey.self] = newValue }
//    }
//}

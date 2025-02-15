//
//  BlogViewModel.swift
//  Wastory
//
//  Created by 중워니 on 01/07/25.
//



import SwiftUI
import Observation

@Observable final class BlogViewModel {
    var blog: Blog = Blog.defaultBlog
    
    var isMyBlog: Bool = false
    
    
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    
    var isCategorySheetPresent: Bool = false
    
    var categories: [Category] = []
    
    var selectedCategory: Category = Category.allCategory
    
    
    
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= 100 {
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
    
    
    func toggleIsCategorySheetPresent() {
        withAnimation(.easeInOut) {
            isCategorySheetPresent.toggle()
        }
    }
    
    func getCategoriesCount() -> Int {
        categories.count
    }
    
    func isCurrentCategory(is category: Category) -> Bool {
        selectedCategory == category
    }
    
    func setCategory(to category: Category) {
        selectedCategory = category
    }
    
    
    
    //pagination
    var page = 1
    var isPageEnded: Bool = false
    
    func resetPage() {
        page = 1
        isPageEnded = false
        blogPosts = []
    }
    
    
    //Network
    var popularBlogPosts: [Post] = []
    
    var blogPosts: [Post] = []
    
    
    var subscriberCount: Int = 0
    
    var subscribingCount: Int = 0
    
    
    func initBlog(_ blogID: Int) async {
        if blogID == UserInfoRepository.shared.getBlogID() {
            isMyBlog = true
        }
        do {
            self.blog = try await NetworkRepository.shared.getBlogByID(blogID: blogID)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // - 블로그 내 글List get하기 (pagination 기능 있음)
    func getPostsInBlog() async {
        if !isPageEnded {
            do {
                let response = try await NetworkRepository.shared.getArticlesInBlog(blogID: self.blog.id, page: self.page)
                
                //comments 저장
                if self.page == 1 {
                    blogPosts = response
                } else {
                    blogPosts.append(contentsOf: response)
                }
                
                //pagination
                if !response.isEmpty {
                    self.page += 1
                } else {
                    self.isPageEnded = true
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // - 블로그 내 카테고리 글 get하기
    func getPostsInCategory() async {
        if !isPageEnded {
            if selectedCategory.id != -1 {
                do {
                    let response = try await NetworkRepository.shared.getArticlesInBlogInCategory(blogID: self.blog.id, categoryID: self.selectedCategory.id, page: self.page)
                    
                    //posts 저장
                    if self.page == 1 {
                        blogPosts = response
                    } else {
                        blogPosts.append(contentsOf: response)
                    }
                    
                    //pagination
                    if !response.isEmpty {
                        self.page += 1
                    } else {
                        self.isPageEnded = true
                    }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                await getPostsInBlog()
            }
        }
    }
    
    // - 블로그 내 인기글List views 순으로 get하기
    func getPopularBlogPosts() async {
        do {
            popularBlogPosts = try await NetworkRepository.shared.getTopArticlesInBlog(blogID: self.blog.id, sortBy: PopularPostSortedType.views.api)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    func getCategories() async {
        do {
            categories = [Category.allCategory]
            categories += try await NetworkRepository.shared.getCategoriesInBlog(blogID: blog.id)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getSubscriptionCounts() async {
        do {
            subscriberCount = try await NetworkRepository.shared.getSubscriberBlogs(blogID: blog.id, page: 1).totalCount
            if isMyBlog {
                subscribingCount = try await NetworkRepository.shared.getMySubscribingBlogs(page: 1).totalCount
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}

//
//// Environment Key 정의
//private struct BlogViewModelKey: EnvironmentKey {
//    static let defaultValue = BlogViewModel()
//}
//
//// Environment Values 확장
//extension EnvironmentValues {
//    var blogViewModel: BlogViewModel {
//        get { self[BlogViewModelKey.self] }
//        set { self[BlogViewModelKey.self] = newValue }
//    }
//}

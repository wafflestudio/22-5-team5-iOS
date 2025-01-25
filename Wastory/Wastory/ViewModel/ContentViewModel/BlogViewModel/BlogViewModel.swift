//
//  BlogViewModel.swift
//  Wastory
//
//  Created by 중워니 on 01/07/25.
//



import SwiftUI
import Observation

@Observable final class BlogViewModel {
    var blog: Blog?
    
    func initBlog(_ blog: Blog) {
        self.blog = blog
    }
    
    
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    
    var isCategorySheetPresent: Bool = false
    
    var categoryItems: [String] = ["분류 전체보기", "Travel", "Food", "Fashion", "Beauty", "Tech", "Life", "Entertainment"] //기본으로 카테고리 없음은 가지고 있어야함
    
    var selectedCategory: String = "분류 전체보기"
    
    
    
    
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
    
    func getCategoryItemsCount() -> Int {
        categoryItems.count
    }
    
    func isCurrentCategory(is category: String) -> Bool {
        selectedCategory == category
    }
    
    func setCategory(to category: String) {
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
    
    // - 블로그 내 글List get하기 (pagination 기능 있음)
    func getPostsInBlog() async {
        if !isPageEnded {
            do {
                let response = try await NetworkRepository.shared.getArticlesInBlog(blogID: self.blog!.id, page: self.page)
                
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
    
    // - 블로그 내 인기글List views 순으로 get하기
    func getPopularBlogPosts() async {
        do {
            popularBlogPosts = try await NetworkRepository.shared.getTopArticlesInBlog(blogID: self.blog!.id, sortBy: PopularPostSortedType.views.api)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}


// Environment Key 정의
private struct BlogViewModelKey: EnvironmentKey {
    static let defaultValue = BlogViewModel()
}

// Environment Values 확장
extension EnvironmentValues {
    var blogViewModel: BlogViewModel {
        get { self[BlogViewModelKey.self] }
        set { self[BlogViewModelKey.self] = newValue }
    }
}

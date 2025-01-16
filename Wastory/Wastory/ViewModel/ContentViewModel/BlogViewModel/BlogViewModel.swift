//
//  BlogViewModel.swift
//  Wastory
//
//  Created by 중워니 on 01/07/25.
//



import SwiftUI
import Observation

@Observable final class BlogViewModel {
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    
    var isCategorySheetPresent: Bool = false
    
    let sheetTopSpace: CGFloat = 30
    let sheetRowHeight: CGFloat = 60
    let sheetBottomSpace: CGFloat = 30
    
    var categoryItems: [String] = ["분류 전체보기", "Travel", "Food", "Fashion", "Beauty", "Tech", "Life", "Entertainment"] //기본으로 카테고리 없음은 가지고 있어야함
    
    var selectedCategory: String = "분류 전체보기"
    
    
    var popularBlogPostItems: [String] = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8", "item 9", "item 10"]
    
    var blogPostListItems: [String] = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8", "item 9", "item 10"]
    
    
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

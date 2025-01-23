//
//  PopularBlogPostSheetViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/12/25.
//



import SwiftUI
import Observation

@Observable final class PopularBlogPostSheetViewModel {
    var blog: Blog?
    
    func initBlog(_ blog: Blog) {
        self.blog = blog
    }
    
    
    
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    var isNavigationToNextPost: Bool = false
    
    
    private var sortCriterion: PopularPostSortedType = .views
    
    let sortCriterions: [PopularPostSortedType] = [.views, .likes, .comments]
    
    var popularBlogPostItems: [String] = ["item 1", "item 2", "item 3", "item 4", "item 5", "item 6", "item 7", "item 8", "item 9", "item 10", "item 11", "item 12", "item 13", "item 14", "item 15", "item 16", "item 17", "item 18", "item 19", "item 20"]
    
    
    var isCriterionSelectionSheetPresent: Bool = false
    
    
    
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= 60 {
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
    
    
    func getSortCriterion() -> PopularPostSortedType {
        sortCriterion
    }
    
    func setSortCriterion(to criterion: PopularPostSortedType) {
        sortCriterion = criterion
    }
    
    func isCurrentSortCriterion(is criterion: PopularPostSortedType) -> Bool {
        sortCriterion == criterion
    }
    
    func toggleIsCriterionSelectionSheetPresent() {
        withAnimation(.easeInOut) {
            isCriterionSelectionSheetPresent.toggle()
        }
    }
    
    
    //Network
    var popularBlogPosts: [Post] = []
    
    func getPopularBlogPosts() async {
        do {
            popularBlogPosts = try await NetworkRepository.shared.getTopArticlesInBlog(blogID: self.blog!.id, sortBy: sortCriterion.api)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}


enum PopularPostSortedType: String, CaseIterable {
    case views
    case comments
    case likes
    
    var korName: String {
        switch self {
        case .views:
            return "조회순"
        case .comments:
            return "댓글순"
        case .likes:
            return "공감순"
        }
    }
    
    var api: String {
        switch self {
        case .views:
            return "views"
        case .comments:
            return "comments"
        case .likes:
            return "likes"
        }
    }
}


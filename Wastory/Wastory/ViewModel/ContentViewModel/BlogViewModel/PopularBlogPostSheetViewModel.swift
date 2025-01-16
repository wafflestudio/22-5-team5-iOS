//
//  PopularBlogPostSheetViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/12/25.
//



import SwiftUI
import Observation

@Observable final class PopularBlogPostSheetViewModel {
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    var isNavigationToNextPost: Bool = false
    
    
    private var sortCriterion: String = "조회순"
    
    let sortCriterions = ["조회순", "공감순", "댓글순"]
    
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
    
    
    func getSortCriterion() -> String {
        sortCriterion
    }
    
    func setSortCriterion(to criterion: String) {
        sortCriterion = criterion
    }
    
    func isCurrentSortCriterion(is criterion: String) -> Bool {
        sortCriterion == criterion
    }
    
    func toggleIsCriterionSelectionSheetPresent() {
        withAnimation(.easeInOut) {
            isCriterionSelectionSheetPresent.toggle()
        }
    }
}

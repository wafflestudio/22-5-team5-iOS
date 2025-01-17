//
//  MyCategoryView.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//

import SwiftUI
import Observation

@Observable final class MyCategoryViewModel {
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= initialScrollPosition - 53 {
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
    
    // category
    
    var writingCategoryName: String = ""
    
    var isCategoryAddButtonActivated: Bool = false
    
    func clearWritingCategoryName() {
        writingCategoryName = ""
    }
    
    
    var selectedCategoryId: Int = -1
    
    func cancleCategoryAddButton() {
        clearWritingCategoryName()
        isCategoryAddButtonActivated = false
    }
    
    func toggleSelectedCategoryId(to id: Int) {
        if selectedCategoryId == id {
            selectedCategoryId = -1
        } else {
            isCategoryEditing = false
            isCategoryAdding = false
            isCategoryDelete = false
            selectedCategoryId = id
            cancleCategoryAddButton()
        }
    }
    
    func unselectCategoryId() {
        selectedCategoryId = -1
    }
    
    func isCategorySelected(_ id: Int) -> Bool {
        selectedCategoryId == id
    }
    
    var isCategoryEditing: Bool = false
    var isCategoryAdding: Bool = false
    var isCategoryDelete: Bool = false
    
    var isCategoryAddingOrEditing: Bool {
        isCategoryAdding || isCategoryEditing
    }
    
    
    
    //Network
    
    var categories: [Category] = [Category.init(id: 0, categoryName: "asdf", level: 0), Category.init(id: 1, categoryName: "asasdfasdfdfasasdfasdfdf", level: 0, children: [Category.init(id: 5, categoryName: "child1", level: 1), Category.init(id: 6, categoryName: "child2", level: 1)]), Category.init(id: 2, categoryName: "asdf", level: 0),]
}

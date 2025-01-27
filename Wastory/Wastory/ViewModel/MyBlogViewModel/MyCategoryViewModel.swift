//
//  MyCategoryView.swift
//  Wastory
//
//  Created by 중워니 on 1/17/25.
//

import SwiftUI
import Observation

@MainActor
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
    
    func cancelCategoryAddButton() {
        clearWritingCategoryName()
        isCategoryAddButtonActivated = false
    }
    
    func toggleSelectedCategoryId(with id: Int) {
        if selectedCategoryId == id {
            selectedCategoryId = -1
            print(selectedCategoryId)
        } else {
            isCategoryEditing = false
            isCategoryAdding = false
            isCategoryDelete = false
            selectedCategoryId = id
            cancelCategoryAddButton()
            print(selectedCategoryId)
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
    
    func setCategoryEditing() {
        isCategoryAdding = false
        isCategoryDelete = false
        isCategoryEditing = true
    }
    
    func setCategoryAdding() {
        isCategoryAdding = true
        isCategoryDelete = false
        isCategoryEditing = false
    }
    
    func clearIfTextEmpty() {
        if writingCategoryName.isEmpty {
            unselectCategoryId()
            cancelCategoryAddButton()
            isCategoryAdding = false
            isCategoryEditing = false
        }
    }
    
    //Network
    var categories: [Category] = []
    
    func postCategory() async {
        do {
            print(selectedCategoryId)
            try await NetworkRepository.shared.postCategory(categoryName: writingCategoryName, parentID: (selectedCategoryId == -1 ? nil : selectedCategoryId))
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getCategories() async {
        do {
            categories = try await NetworkRepository.shared.getCategoriesInBlog(blogID: UserInfoRepository.shared.getBlogID())
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func patchCategory() async {
        do {
            try await NetworkRepository.shared.patchCategory(categoryName: writingCategoryName, categoryID: selectedCategoryId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func deleteCategory() async {
        do {
            try await NetworkRepository.shared.deleteCategory(categoryID: selectedCategoryId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

//
//  ArticleSettingViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import Observation
import RichTextKit

@Observable final class ArticleSettingViewModel {
    private let title: String
    private let text: NSAttributedString
    
    var mainImage: UIImage? = nil
    var isImagePickerPresented: Bool = false
    
    var category: Category = Category.allCategory
    var isCategorySheetPresent: Bool = false
    var categories: [Category] = []
    
    var homeTopic: HomeTopic = HomeTopic.defaultHomeTopic
    var isCommentEnabled: Bool = true

    init(title: String, text: NSAttributedString) {
        self.title = title
        self.text = text
    }
    
    // MARK: - Posting
    
    // MARK: - Title & Image
    func getTitle() -> String {
        return title
    }
    
    func toggleImagePickerPresented() {
        isImagePickerPresented.toggle()
    }
    
    // MARK: - Category
    func toggleIsCategorySheetPresent() {
        isCategorySheetPresent.toggle()
    }
    
    func getCategories() async {
        do {
            categories += try await NetworkRepository.shared.getCategoriesInUser()
            category = categories[0]
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getCategoriesCount() -> Int {
        return categories.count
    }
    
    func setCategory(category: Category) {
        self.category = category
    }
    
    func isSelectedCategory(category: Category) -> Bool {
        return self.category == category
    }
    
    // MARK: - Optional: Public, HomeTopic, Comment
}

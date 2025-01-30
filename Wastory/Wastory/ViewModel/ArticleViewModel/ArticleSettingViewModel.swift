//
//  ArticleSettingViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import Observation
import RichTextKit

@MainActor
@Observable final class ArticleSettingViewModel {
    private let title: String
    private let text: NSAttributedString
    
    var mainImage: UIImage? = nil
    var isImagePickerPresented: Bool = false
    var mainImageURL: String? = nil
    
    var category: Category = Category.allCategory
    var isCategorySheetPresent: Bool = false
    var categories: [Category] = []
    
    var homeTopic: HomeTopic = HomeTopic(id: 1, name: "선택 안 함", highCategory: 0)
    var isHomeTopicSheetPresent: Bool = false
    let defaultHomeTopic: HomeTopic = HomeTopic(id: 1, name: "선택 안 함", highCategory: 0)
    let highCategories: [HomeTopic] = [
        HomeTopic(id: 2, name: "여행·맛집", highCategory: 0),
        HomeTopic(id: 3, name: "리빙·스타일", highCategory: 0),
        HomeTopic(id: 4, name: "가족·연애", highCategory: 0),
        HomeTopic(id: 5, name: "직장·자기계발", highCategory: 0),
        HomeTopic(id: 6, name: "시사·지식", highCategory: 0),
        HomeTopic(id: 7, name: "도서·창작", highCategory: 0),
        HomeTopic(id: 8, name: "엔터테인먼트", highCategory: 0),
        HomeTopic(id: 9, name: "취미·건강", highCategory: 0)
    ]
    let homeTopics: [[HomeTopic]] = [
        [   // 여행·맛집
            HomeTopic(id: 10, name: "국내여행", highCategory: 2),
            HomeTopic(id: 11, name: "해외여행", highCategory: 2),
            HomeTopic(id: 12, name: "캠핑·등산", highCategory: 2),
            HomeTopic(id: 13, name: "맛집", highCategory: 2),
            HomeTopic(id: 14, name: "카페·디저트", highCategory: 2)
        ],
        [   // 리빙·스타일
            HomeTopic(id: 15, name: "생활정보", highCategory: 3),
            HomeTopic(id: 16, name: "인테리어", highCategory: 3),
            HomeTopic(id: 17, name: "패션·뷰티", highCategory: 3),
            HomeTopic(id: 18, name: "요리", highCategory: 3)
        ],
        [   // 가족·연애
            HomeTopic(id: 19, name: "일상", highCategory: 4),
            HomeTopic(id: 20, name: "연애·결혼", highCategory: 4),
            HomeTopic(id: 21, name: "육아", highCategory: 4),
            HomeTopic(id: 22, name: "해외생활", highCategory: 4),
            HomeTopic(id: 23, name: "군대", highCategory: 4),
            HomeTopic(id: 24, name: "반려동물", highCategory: 4)
        ],
        [   // 직장·자기계발
            HomeTopic(id: 25, name: "IT 인터넷", highCategory: 5),
            HomeTopic(id: 26, name: "모바일", highCategory: 5),
            HomeTopic(id: 27, name: "과학", highCategory: 5),
            HomeTopic(id: 28, name: "IT 제품리뷰", highCategory: 5),
            HomeTopic(id: 29, name: "경영·직장", highCategory: 5)
        ],
        [   // 시사·지식
            HomeTopic(id: 30, name: "정치", highCategory: 6),
            HomeTopic(id: 31, name: "사회", highCategory: 6),
            HomeTopic(id: 32, name: "교육", highCategory: 6),
            HomeTopic(id: 33, name: "국제", highCategory: 6),
            HomeTopic(id: 34, name: "경제", highCategory: 6)
        ],
        [   // 도서·창작
            HomeTopic(id: 35, name: "책", highCategory: 7),
            HomeTopic(id: 36, name: "창작", highCategory: 7)
        ],
        [   // 엔터테인먼트
            HomeTopic(id: 37, name: "TV", highCategory: 8),
            HomeTopic(id: 38, name: "스타", highCategory: 8),
            HomeTopic(id: 39, name: "영화", highCategory: 8),
            HomeTopic(id: 40, name: "음악", highCategory: 8),
            HomeTopic(id: 41, name: "만화·애니", highCategory: 8),
            HomeTopic(id: 42, name: "공연·전시·축제", highCategory: 8)
        ],
        [   // 취미·건강
            HomeTopic(id: 43, name: "취미", highCategory: 9),
            HomeTopic(id: 44, name: "건강", highCategory: 9),
            HomeTopic(id: 45, name: "스포츠일반", highCategory: 9),
            HomeTopic(id: 46, name: "축구", highCategory: 9),
            HomeTopic(id: 47, name: "야구", highCategory: 9),
            HomeTopic(id: 48, name: "농구", highCategory: 9),
            HomeTopic(id: 49, name: "배구", highCategory: 9),
            HomeTopic(id: 50, name: "골프", highCategory: 9),
            HomeTopic(id: 51, name: "자동차", highCategory: 9),
            HomeTopic(id: 52, name: "게임", highCategory: 9),
            HomeTopic(id: 53, name: "사진", highCategory: 9),
        ]
    ]
    
    var isSecret: Bool = false
    var isProtected: Bool = false
    var articlePassword: String = ""
    var isCommentEnabled: Bool = true

    init(title: String, text: NSAttributedString) {
        self.title = title
        self.text = text
    }
    
    func extractMainImage() {
        var firstImage: UIImage? = nil
        text.enumerateAttributes(in: NSRange(location: 0, length: text.length), options: []) { attributes, range, stop in
            if let attachment = attributes[.attachment] as? NSTextAttachment {
                if let image = attachment.image {
                    firstImage = image
                    stop.pointee = true
                }
            }
        }
        mainImage = firstImage
    }
    
    // MARK: - Posting
    func postArticle() async {
        if let image = mainImage {
            do {
                let response = try await NetworkRepository.shared.postImage(image)
                mainImageURL = response
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        let (processedText, URLs) = await RichTextImageHandler.convertImage(text)
        if let dataText = RichTextHandler.textToData(processedText) {
            do {
                try await NetworkRepository.shared.postArticle(
                    title: title,
                    content: dataText,
                    description: getDescription(),
                    main_image_url: mainImageURL ?? (URLs.isEmpty ? "" : URLs[0].fileURL),
                    categoryID: category.id,
                    homeTopicID: homeTopic.id,
                    secret: isSecret ? 1 : 0,
                    protected: isProtected ? 1 : 0,
                    password: articlePassword,
                    images: URLs,
                    commentsEnabled: isCommentEnabled ? 1 : 0
                )
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func patchArticle(postID: Int) async {
        if let image = mainImage {
            do {
                let response = try await NetworkRepository.shared.postImage(image)
                mainImageURL = response
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        let (processedText, URLs) = await RichTextImageHandler.convertImage(text)
        if let dataText = RichTextHandler.textToData(processedText) {
            do {
                try await NetworkRepository.shared.patchArticle(
                    postID: postID,
                    title: title,
                    content: dataText,
                    description: getDescription(),
                    main_image_url: mainImageURL ?? (URLs.isEmpty ? "" : URLs[0].fileURL),
                    categoryID: category.id,
                    homeTopicID: homeTopic.id,
                    secret: isSecret ? 1 : 0,
                    protected: isProtected ? 1 : 0,
                    password: articlePassword,
                    images: URLs,
                    commentsEnabled: isCommentEnabled ? 1 : 0
                )
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getDescription() -> String {
        let mutableAttrString = NSMutableAttributedString(attributedString: text)
                
        mutableAttrString.enumerateAttribute(.attachment, in: NSRange(location: 0, length: mutableAttrString.length)) { value, range, _  in
            if value is NSTextAttachment {
                mutableAttrString.replaceCharacters(in: range, with: "")
            }
        }
                
        let pureText = mutableAttrString.string
        let cleanedText = pureText
            .replacingOccurrences(of: "\n", with: " ")
            .components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
        print("desc.: ", cleanedText)
        return cleanedText
    }

    // MARK: - Title & Image
    func getTitle() -> String {
        return title
    }
    
    func toggleImagePickerPresented() {
        isImagePickerPresented.toggle()
    }
    
    func postImage() async {
        do {
            if let _ = mainImage {
                mainImageURL = try await NetworkRepository.shared.postImage(mainImage!)
            }
        } catch {
            print("Error uploading image: \(error.localizedDescription)")
        }
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
    
    // MARK: - HomeTopic
    func toggleIsHomeTopicSheetPresent() {
        isHomeTopicSheetPresent.toggle()
    }
    
    func getHighCategoriesCount() -> Int {
        return highCategories.count
    }
    
    func setHomeTopic(homeTopic: HomeTopic) {
        self.homeTopic = homeTopic
    }
    
    func isSelectedHomeTopic(homeTopic: HomeTopic) -> Bool {
        return self.homeTopic == homeTopic
    }
    
    // MARK: - Optional: Secret, Comment
    func generateRandomPassword(length: Int) -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
}

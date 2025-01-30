//
//  ArticleViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//  Modified by mujigae on 1/13/25.
//

import SwiftUI
import Observation
import RichTextKit

@MainActor
@Observable final class ArticleViewModel {
    var title: String = ""
    var text = NSAttributedString()
    var context = RichTextContext()
    
    let cautionDuration: Double = 1.6
    var isEmptyDraftEntered: Bool = false
    var isEmptyTitleEntered: Bool = false
    var isDraftSaved: Bool = false
    var isDraftDeleted: Bool = false
    var isImageLoading: Bool = false
    var isImageLoadPending: Bool = false
    
    private var page: Int = 1
    private var isPageEnded: Bool = false
    var draftsCount: Int = 0
    var drafts: [DraftDto] = []
    var currentDraftID: Int = -1
    var isDraftSheetPresent: Bool = false
    var resetEditor: Bool = false
    var deleteDraftID: Int = -1
    var isDraftDeleteSheetPresent: Bool = false
    var showDeleteAlert: Bool = false
    
    var inputImage: UIImage?
    var isGalleryPickerPresent: Bool = false
    var isCameraPickerPresent: Bool = false
    let screenWidth: CGFloat = UIScreen.main.bounds.width - 40
    
    var isSubmitted: Bool = false
    
    var editingPost: Post?
    
    func initEditingPost(post: Post) async {
        editingPost = post
        
        title = editingPost!.title
        if let loadedText = RichTextHandler.DataTotext(editingPost?.content ?? "") {
            let restoredText = await RichTextImageHandler.restoreImage(loadedText, screenWidth: screenWidth)
            text = restoredText
        }
    }
    
    func insertImage(inputImage: UIImage, context: RichTextContext) {
        let cursorLocation = context.selectedRange.location
        
        let attachment = CustomTextAttachment()
        attachment.image = inputImage
        attachment.originalImage = inputImage
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16)    // 이미지가 삽입되어도 기존 폰트 사이즈를 유지 (유저가 입력하면서 변경 가능)
        ]
        let attributedString = NSAttributedString(attachment: attachment, attributes: attributes)
        let action = RichTextAction.replaceText(in: NSRange(location: cursorLocation, length: 0), with: attributedString)
        context.handle(action)
    }
    
    func resetView() async {
        page = 1
        isPageEnded = false
        await getDrafts()
        deleteDraftID = -1
    }
    
    func getDrafts() async {
        if !isPageEnded {
            do {
                let response = try await NetworkRepository.shared.getDraftsInBlog(
                    blogID: UserInfoRepository.shared.getBlogID(),
                    page: page
                )
                draftsCount = response.totalCount
                if page == 1 {
                    drafts = response.drafts
                }
                else {
                    drafts += response.drafts
                }
                page += 1
                if drafts.count == draftsCount {
                    isPageEnded = true
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getDraftsCount() -> String {
        return String(draftsCount)
    }
    
    func getDraft(draftID: Int) async {
        do {
            let response = try await NetworkRepository.shared.getDraft(draftID: draftID)
            title = response.title
            if let loadedText = RichTextHandler.DataTotext(response.content) {
                let restoredText = await RichTextImageHandler.restoreImage(loadedText, screenWidth: screenWidth)
                text = restoredText
            }
            else {
                print("Error: Failed to load text data")
            }
            currentDraftID = response.id
            resetEditor.toggle()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func storeDraft() async {
        let processedText = await RichTextImageHandler.convertImage(text).text
        if let dataText = RichTextHandler.textToData(processedText) {
            if currentDraftID < 0 {
                do {
                    let response = try await NetworkRepository.shared.postDraft(title: title, content: dataText)
                    currentDraftID = response.id
                } catch {
                    print("Store Error: \(error.localizedDescription)")
                }
            } else {
                do {
                    try await NetworkRepository.shared.patchDraft(title: title, content: dataText, draftID: currentDraftID)
                } catch {
                    print("Patch Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteDraft() async {
        do {
            try await NetworkRepository.shared.deleteDraft(draftID: deleteDraftID)
            await resetView()
            currentDraftID = -1
            deleteDraftID = -1
        } catch {
            print("Delete Draft Error: \(error.localizedDescription)")
        }
    }
    
    func toggleIsDraftSheetPresent() {
        isDraftSheetPresent.toggle()
    }
    
    func toggleIsDraftDeleteSheetPresent() {
        isDraftDeleteSheetPresent.toggle()
    }
}

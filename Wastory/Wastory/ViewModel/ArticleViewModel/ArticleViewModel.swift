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
    
    private var page: Int = 1
    private var isPageEnded: Bool = false
    var draftsCount: Int = 0
    var drafts: [DraftDto] = []
    var currentDraftID: Int = -1
    var isDraftSheetPresent: Bool = false
    var resetEditor: Bool = false
    
    var inputImage: UIImage?
    var isGalleryPickerPresent: Bool = false
    var isCameraPickerPresent: Bool = false
    
    func insertImage(inputImage: UIImage, context: RichTextContext) {
        let cursorLocation = context.selectedRange.location
        let insertion = RichTextInsertion<UIImage>.image(inputImage, at: cursorLocation, moveCursor: true)
        let action = RichTextAction.pasteImage(insertion)
        context.handle(action)
    }
    
    func resetView() async {
        page = 1
        isPageEnded = false
        await getDrafts()
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
                let restoredText = await RichTextImageHandler.restoreImage(loadedText)
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
        let processedText = await RichTextImageHandler.convertImage(text)
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
    
    func toggleIsDraftSheetPresent() {
        isDraftSheetPresent.toggle()
    }
}

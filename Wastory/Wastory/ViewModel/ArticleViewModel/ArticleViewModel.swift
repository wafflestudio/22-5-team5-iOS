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

@Observable final class ArticleViewModel {
    var title: String = ""
    var text = NSAttributedString()
    var context = RichTextContext()
    
    var isEmptyTitleEntered: Bool = false
    
    private var page: Int = 1
    var draftsCount: Int = 0
    var drafts: [Draft] = []
    var currentDraftID: Int = -1
    
    func getDrafts() async {
        if drafts.count < draftsCount {
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
            if let loadedText = HTMLTotext(response.content) {
                text = loadedText
            }
            currentDraftID = response.id
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func storeDraft() async {
        if let htmlText = textToHTML(text) {
            if currentDraftID < 0 {
                do {
                    let response = try await NetworkRepository.shared.postDraft(title: title, content: htmlText)
                    currentDraftID = response.id
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                do {
                    try await NetworkRepository.shared.patchDraft(title: title, content: htmlText, draftID: currentDraftID)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Converters
    func HTMLTotext(_ htmlString: String) -> NSAttributedString? {
        guard let htmlData = htmlString.data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSAttributedString(
                data: htmlData,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            return attributedString
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
        }
        return nil
    }
    
    func textToHTML(_ text: NSAttributedString) -> String? {
        do {
            let htmlData = try text.data(
                from: NSRange(location: 0, length: text.length),
                documentAttributes: [.documentType: NSAttributedString.DocumentType.html]
            )
            if let htmlString = String(data: htmlData, encoding: .utf8) {
                return htmlString
            }
        }
        catch {
            print("Error convertnig Rich Text to HTML: \(error)")
        }
        return nil
    }
}

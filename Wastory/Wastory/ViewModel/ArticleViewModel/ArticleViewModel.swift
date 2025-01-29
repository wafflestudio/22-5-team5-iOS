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
    
    let cautionDuration: Double = 1.6
    var isEmptyDraftEntered: Bool = false
    var isEmptyTitleEntered: Bool = false
    
    private var page: Int = 1
    private var isPageEnded: Bool = false
    var draftsCount: Int = 0
    var drafts: [DraftDto] = []
    var currentDraftID: Int = -1
    var isDraftSheetPresent: Bool = false
    
    init(title: String, text: NSAttributedString) {
        self.title = title
        self.text = text
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
        /*
        do {
            let response = try await NetworkRepository.shared.getDraft(draftID: draftID)
            title = response.title
            if let loadedText = HTMLTotext(response.content) {
                text = loadedText
                print("로드 성공: \(text.string)")
                print(text)
            }
            currentDraftID = response.id
        } catch {
            print("Error: \(error.localizedDescription)")
        }*/
        
        /*
        do {
            let response = try await NetworkRepository.shared.getDraft(draftID: draftID)
            title = response.title
            if let loadedText = RTFTotext(response.content) {
                text = loadedText
                print("로드 성공: \(text.string)")
                print(text)
            }
            currentDraftID = response.id
        } catch {
            print("Error: \(error.localizedDescription)")
        }*/
        
        do {
            let response = try await NetworkRepository.shared.getDraft(draftID: draftID)
            title = response.title
            if let loadedText = DataTotext(response.content) {
                text = loadedText
                print("로드 성공: \(text.string)")
                print(text)
            }
            currentDraftID = response.id
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func storeDraft() async {
        /*
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
        }*/
        
        /*
        if let rtfText = textToRTF(text) {
            if currentDraftID < 0 {
                do {
                    let response = try await NetworkRepository.shared.postDraft(title: title, content: rtfText)
                    currentDraftID = response.id
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                do {
                    try await NetworkRepository.shared.patchDraft(title: title, content: rtfText, draftID: currentDraftID)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }*/
        
        if let dataText = textToData(text) {
            if currentDraftID < 0 {
                do {
                    let response = try await NetworkRepository.shared.postDraft(title: title, content: dataText)
                    currentDraftID = response.id
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                do {
                    try await NetworkRepository.shared.patchDraft(title: title, content: dataText, draftID: currentDraftID)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func toggleIsDraftSheetPresent() {
        isDraftSheetPresent.toggle()
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
                documentAttributes: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
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
    
    func textToRTF(_ text: NSAttributedString) -> String? {
        do {
            let rtfData = try text.data(
                from: NSRange(location: 0, length: text.length),
                documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])
            return rtfData.base64EncodedString()
        }
        catch {
            print("Error convertnig Rich Text to RTF: \(error)")
        }
        return nil
    }
    
    func RTFTotext(_ rtfString: String) -> NSAttributedString? {
        do {
            let rtfData = Data(base64Encoded: rtfString)
            return try NSAttributedString(
                data: rtfData!,
                options: [.documentType: NSAttributedString.DocumentType.rtf],
                documentAttributes: nil)
        }
        catch {
            print("Error convertnig RTF to Rich Text: \(error)")
        }
        return nil
    }
    
    func textToData(_ text: NSAttributedString) -> String? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: text, requiringSecureCoding: false)
            return data.base64EncodedString()
        } catch {
            print("Failed to archive NSAttributedString: \(error)")
            return nil
        }
    }
    
    func DataTotext(_ data: String) -> NSAttributedString? {
        if let text = Data(base64Encoded: data) {
            do {
                return try NSAttributedString(data: text, format: .archivedData)
            } catch {
                print("Failed to load NSAttributedString: \(error)")
            }
        }
        return nil
    }
}

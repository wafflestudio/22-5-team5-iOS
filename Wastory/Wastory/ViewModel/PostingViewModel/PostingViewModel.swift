//
//  PostingViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/6/25.
//  Modified by mujigae on 1/13/25.
//

import SwiftUI
import Observation
import RichTextKit

@Observable final class PostingViewModel {
    var title: String = ""
    var text = NSAttributedString()
    var context = RichTextContext()
    private var tempPostCount: Int = 0
    
    func getTempPostCount() -> String {
        return String(tempPostCount)
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
    
    func postArticle() async {
        let htmlText = textToHTML(text)
        if htmlText != nil {
            do {
                try await NetworkRepository.shared.postArticle(
                    title: title,
                    content: htmlText ?? "",
                    description: "임시 내용",
                    categoryID: 0
                )
                print("게시글 작성 성공")
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

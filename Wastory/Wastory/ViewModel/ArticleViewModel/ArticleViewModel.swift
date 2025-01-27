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
    private var tempPostCount: Int = 0
    
    var isEmptyTitleEntered: Bool = false
    
    func getTempPostCount() -> String {
        return String(tempPostCount)
    }
}

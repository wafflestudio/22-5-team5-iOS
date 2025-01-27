//
//  PostSettingViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/16/25.
//

import SwiftUI
import Observation
import RichTextKit

@MainActor
@Observable final class PostSettingViewModel {
    private let title: String
    private let text: NSAttributedString
    
    var mainImage: UIImage? = nil
    var isImagePickerPresented: Bool = false

    init(title: String, text: NSAttributedString) {
        self.title = title
        self.text = text
    }
    
    func getTitle() -> String {
        return title
    }
    
    func toggleImagePickerPresented() {
        isImagePickerPresented.toggle()
    }
}

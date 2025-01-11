//
//  RichTextEditor.swift
//  Wastory
//
//  Created by mujigae on 1/11/25.
//

import SwiftUI
import UIKit

struct RichTextEditor: UIViewRepresentable {
    @Binding var text: NSAttributedString
    
    func updateUIView(_ uiView: UITextView, context: Context) {
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        
        let initialFont = UIFont.systemFont(ofSize: 15)
        let initialParagraphStyle = NSMutableParagraphStyle()
        initialParagraphStyle.lineSpacing = 8
        let initialAttributes = [
            NSAttributedString.Key.font: initialFont,
            NSAttributedString.Key.paragraphStyle: initialParagraphStyle
        ]
        textView.typingAttributes = initialAttributes
        
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.delegate = context.coordinator
        return textView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: RichTextEditor
        
        init(_ parent: RichTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.attributedText
        }
    }
}

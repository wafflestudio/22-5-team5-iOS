//
//  RichTextEditor.swift
//  Wastory
//
//  Created by mujigae on 1/11/25.
//

import SwiftUI
import UIKit

struct RichTextEditor: UIViewRepresentable {
    
    func updateUIView(_ uiView: UITextView, context: Context) {
    }
    
    @State var text: NSAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        return UITextView()
    }
}

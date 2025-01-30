//
//  RichTextHandler.swift
//  Wastory
//
//  Created by mujigae on 1/29/25.
//

import SwiftUI

class RichTextHandler {
    // MARK: - Converters
    // MARK: Main Converter
    static func textToData(_ text: NSAttributedString) -> String? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: text, requiringSecureCoding: false)
            return data.base64EncodedString()
        } catch {
            print("Failed to archive NSAttributedString: \(error)")
            return nil
        }
    }
    
    static func DataTotext(_ data: String) -> NSAttributedString? {
        if let text = Data(base64Encoded: data) {
            do {
                return try NSAttributedString(data: text, format: .archivedData)
            } catch {
                print("Failed to load NSAttributedString: \(error)")
            }
        }
        return nil
    }
    
    // MARK: Sub Converter (may not use)
    static func HTMLTotext(_ htmlString: String) -> NSAttributedString? {
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
    
    static func textToHTML(_ text: NSAttributedString) -> String? {
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
    
    static func textToRTF(_ text: NSAttributedString) -> String? {
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
    
    static func RTFTotext(_ rtfString: String) -> NSAttributedString? {
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
}

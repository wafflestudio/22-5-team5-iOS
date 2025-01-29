//
//  RichTextImageHandler.swift
//  Wastory
//
//  Created by mujigae on 1/29/25.
//

import SwiftUI
import Kingfisher

@MainActor
class RichTextImageHandler {
    // 이미지를 URL로 변환하고 NSAttributedString을 수정하는 함수
    static func convertImagesToURLs(_ attributedString: NSAttributedString) async -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        
        attributedString.enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedString.length)) { value, range, _ in
            guard let attachment = value as? NSTextAttachment,
                  let image = attachment.image else { return }
            
            // 이미지 업로드 및 URL 획득
            Task {
                do {
                    let imageURL = try await NetworkRepository.shared.postImage(image)
                    let urlAttachment = NSTextAttachment()
                    urlAttachment.bounds = attachment.bounds
                    
                    // URL을 저장할 커스텀 속성 추가
                    let attributes: [NSAttributedString.Key: Any] = [
                        .attachment: urlAttachment,
                        .customImageURL: imageURL
                    ]
                    
                    let replacementString = NSAttributedString(string: "📷", attributes: attributes)
                    mutableAttributedString.replaceCharacters(in: range, with: replacementString)
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
        return mutableAttributedString
    }
    
    // URL로부터 이미지를 다운로드하여 NSAttributedString을 복원하는 함수
    static func restoreImagesFromURLs(_ attributedString: NSAttributedString) async -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
        
        attributedString.enumerateAttribute(.customImageURL, in: NSRange(location: 0, length: attributedString.length)) { value, range, _ in
            guard let imageURL = value as? String else { return }
            
            Task {
                if let image = try? await KingfisherManager.shared.retrieveImage(with: .network(imageURL as! Resource)).image {
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = image
                    
                    let replacementString = NSAttributedString(attachment: imageAttachment)
                    mutableAttributedString.replaceCharacters(in: range, with: replacementString)
                }
            }
        }
        
        return mutableAttributedString
    }
}

// 커스텀 속성 키 정의
extension NSAttributedString.Key {
    static let customImageURL = NSAttributedString.Key("customImageURL")
}

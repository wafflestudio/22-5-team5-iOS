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
    // MARK: 이미지를 URL로 변환하고 NSAttributedString을 수정하는 함수
    static func convertImage(_ attributedString: NSAttributedString) async -> (text: NSAttributedString, URLs: [FileURLDto]) {
        let mutableAttrString = NSMutableAttributedString(attributedString: attributedString)
        var attachmentRanges: [(NSRange, NSTextAttachment)] = []
        
        // 모든 이미지 첨부파일의 위치를 수집
        mutableAttrString.enumerateAttribute(.attachment, in: NSRange(location: 0, length: mutableAttrString.length)) { value, range, _ in
            if let attachment = value as? NSTextAttachment {
                attachmentRanges.append((range, attachment))
            }
        }
        
        var URLs: [FileURLDto] = []
        
        // 역순으로 처리
        for (range, attachment) in attachmentRanges.reversed() {
            if let image = attachment.image ?? attachment.image(forBounds: attachment.bounds, textContainer: nil, characterIndex: 0) {
                do {
                    let imageURL = try await NetworkRepository.shared.postImage(image)
                    let imageMarker = "[[IMAGE_URL]]\(imageURL)[[/IMAGE_URL]]"
                    
                    URLs.append(FileURLDto(fileURL: imageURL))
                    
                    // 기존 attachment 속성 제거
                    let attributes = mutableAttrString.attributes(at: range.location, effectiveRange: nil)
                    var newAttributes = attributes
                    newAttributes.removeValue(forKey: .attachment)
                    
                    // URL 텍스트 삽입 및 속성 적용
                    let urlAttrString = NSAttributedString(string: imageMarker, attributes: newAttributes)
                    mutableAttrString.replaceCharacters(in: range, with: urlAttrString)
                    
                    print("Image converted to URL: \(imageURL)")
                } catch {
                    print("Failed to upload image: \(error)")
                }
            }
        }
        
        // attachment 속성 한 번 더 확인하여 제거 - 추후 제거해도 무방할 것으로 보임
        let fullRange = NSRange(location: 0, length: mutableAttrString.length)
        mutableAttrString.enumerateAttribute(.attachment, in: fullRange) { value, range, _ in
            if value != nil {
                mutableAttrString.removeAttribute(.attachment, range: range)
            }
        }
        
        return (mutableAttrString, URLs.reversed())
    }
    
    // MARK: URL로부터 이미지를 복원하는 함수
    static func restoreImage(_ attributedString: NSAttributedString, screenWidth: CGFloat) async -> NSAttributedString {
        let mutableAttrString = NSMutableAttributedString(attributedString: attributedString)
        let pattern = "\\[\\[IMAGE_URL\\]](.+?)\\[\\[/IMAGE_URL\\]]"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attributedString
        }
        
        let matches = regex.matches(in: mutableAttrString.string, options: [], range: NSRange(location: 0, length: mutableAttrString.length))
        
        for match in matches.reversed() {
            guard let urlRange = Range(match.range(at: 1), in: mutableAttrString.string) else { continue }
            let urlString = String(mutableAttrString.string[urlRange])
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL: \(urlString)")
                continue
            }
            
            do {
                let image = try await withCheckedThrowingContinuation { continuation in
                    KingfisherManager.shared.retrieveImage(with: url) { result in
                        switch result {
                        case .success(let imageResult):
                            continuation.resume(returning: imageResult.image)
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
                }
                
                let attachment = ResizableTextAttachment()
                attachment.image = image
                
                let imageAspectRatio = image.size.height / image.size.width
                let height = imageAspectRatio * screenWidth
                
                attachment.desiredHeight = height
                attachment.desiredWidth = screenWidth

                let attributedImage = NSAttributedString(attachment: attachment)
                mutableAttrString.replaceCharacters(in: match.range, with: attributedImage)
                
            } catch {
                print("Image download failed: \(error)")
            }
        }
        
        return mutableAttrString
    }
}

// Custom NSTextAttachment that respects desired size
class ResizableTextAttachment: NSTextAttachment {
    var desiredWidth: CGFloat = 0
    var desiredHeight: CGFloat = 0
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        if desiredWidth > 0 && desiredHeight > 0 {
            return CGRect(x: 0, y: 0, width: desiredWidth, height: desiredHeight)
        }
        return super.attachmentBounds(for: textContainer, proposedLineFragment: lineFrag, glyphPosition: position, characterIndex: charIndex)
    }
}

// Custom NSTextAttachment for resizable insertion
class CustomTextAttachment: NSTextAttachment {
    var originalImage: UIImage?
    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        guard let image = originalImage else {
            return super.attachmentBounds(for: textContainer, proposedLineFragment: lineFrag, glyphPosition: position, characterIndex: charIndex)
        }
        let screenWidth = UIScreen.main.bounds.width - 40
        let imageAspectRatio = image.size.height / image.size.width
        let height = imageAspectRatio * screenWidth
        return CGRect(x: 0, y: 0, width: screenWidth, height: height)
    }
}

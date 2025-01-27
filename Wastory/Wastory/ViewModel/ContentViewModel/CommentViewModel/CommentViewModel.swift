//
//  CommentViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/16/25.
//


import SwiftUI
import Observation

@MainActor
@Observable final class CommentViewModel {
    private var isNavTitleHidden: Bool = true
    
    private var initialScrollPosition: CGFloat = 0
    
    
    func setInitialScrollPosition(_ scrollPosition: CGFloat) {
        initialScrollPosition = scrollPosition
    }
    
    func changeIsNavTitleHidden(by newValue: CGFloat, _ oldValue: CGFloat) {
        if oldValue == initialScrollPosition {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        } else if newValue <= initialScrollPosition - 53 {
            if (isNavTitleHidden) {
                isNavTitleHidden = false
            }
        } else {
            if (!isNavTitleHidden) {
                isNavTitleHidden = true
            }
        }
    }
    
    func getIsNavTitleHidden() -> Bool {
        isNavTitleHidden
    }
    
    
    //pagination
    var page = 1
    var isPageEnded: Bool = false
    
    func resetPage() {
        page = 1
        isPageEnded = false
        comments = []
    }
    
    //Network
    var postID: Int?
    var comments: [Comment] = []
    
    var totalCommentsCount: Int = 0
    
    
    var writingCommentText: String = ""
    var isWritingCommentSecret: Bool = false
    var isTextFieldFocused: Bool = false
    var targetComment: Comment?
    var isTargetToComment: Bool = false
    
    func setPostID(_ id: Int) {
        postID = id
    }
    
    func isWritingCommentEmpty() -> Bool {
        writingCommentText.isEmpty
    }
    
    func resetWritingCommentText() {
        writingCommentText = ""
    }
    
    func setTargetCommentID(to comment: Comment) {
        targetComment = comment
        isTargetToComment = true
    }
    
    func resetTargetCommentID() {
        targetComment = nil
        isTargetToComment = false
    }
    
    func updateIsTextFieldFocused() {
        isTextFieldFocused = false
        isTextFieldFocused = true
    }
    
    func postComment() async {
        if !writingCommentText.isEmpty {
            do {
                _ = try await NetworkRepository.shared.postComment(
                    postID: self.postID ?? 0,
                    content: writingCommentText,
                    parentID: targetComment?.id ?? nil,
                    isSecret: self.isWritingCommentSecret
                )
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getComments() async {
        if !isPageEnded {
            do {
                let response = try await NetworkRepository.shared.getArticleComments(postID: postID ?? 0, page: page)
                
                //comments 저장
                if page == 1 {
                    comments = response.comments
                } else {
                    comments.append(contentsOf: response.comments)
                }
                
                //totalCount 저장
                totalCommentsCount = response.totalCount
                
                //pagination
                if !response.comments.isEmpty {
                    page += 1
                } else {
                    isPageEnded = true
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}


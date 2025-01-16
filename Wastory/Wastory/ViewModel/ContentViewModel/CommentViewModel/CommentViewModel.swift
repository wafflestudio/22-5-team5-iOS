//
//  CommentViewModel.swift
//  Wastory
//
//  Created by 중워니 on 1/16/25.
//


import SwiftUI
import Observation

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
    
    
    //Network
    
    var comments: [Comment] = [Comment.init(id: 1, blogID: 1, children: [Comment.init(id: 2, blogID: 1, content: "comment context waffle studio team 5 lets go bongjunho sonheoungmin Jpar", createdAt: Date(), isSecret: false), Comment.init(id: 3, blogID: 1, content: "comment context waffle studio team 5 lets go bongjunho sonheoungmin Jpar", createdAt: Date(), isSecret: false)], content: "comment context waffle studio team 5 lets go bongjunho sonheoungmin Jpar", createdAt: Date(), isSecret: false), Comment.init(id: 4, blogID: 1, content: "second comment", createdAt: Date(), isSecret: false), Comment.init(id: 5, blogID: 1, content: "second comment", createdAt: Date(), isSecret: false), Comment.init(id: 6, blogID: 1, content: "second comment", createdAt: Date(), isSecret: false), Comment.init(id: 7, blogID: 1, content: "second comment", createdAt: Date(), isSecret: false)]
}


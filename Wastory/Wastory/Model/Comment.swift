//
//  Comment.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Comment: Codable {
    let commentId: Int                  // Comment Id(주소)
    let blogId: Int                     // Comment가 달린
    let userId: String                  // Comment 작성자
    
    let parentId: Int?                  // Comment가 답글 형식일 경우 원댓글의 Id
    
    var content: String                 // 내용
    var createdAt: Date                 // 발행일
    
    var isSecret: Bool                  // 비밀 댓글 여부
}

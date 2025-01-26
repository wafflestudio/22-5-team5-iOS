//
//  Comment.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: Int                  // Comment Id(주소)
    var userName: String                  // Comment 작성자 userName
    
    
    var content: String                 // 내용
    var createdAt: Date                 // 발행일
    
    var isSecret: Int                  // 비밀 댓글 여부
    
    var blogID: Int
    var blogMainImageURL: String?
    var children: [Comment]?                // Comment의 답글 id List
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case content
        case createdAt = "created_at"
        case isSecret = "secret"
        case blogID = "user_blog_id"
        case blogMainImageURL = "blog_main_img"
        case children
    }
}

struct CommentListDto: Codable {
    let page: Int
    let perPage: Int
    let totalCount: Int
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalCount = "total_count"
        case comments
    }
}

//
//  Post.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Post: Codable {
    let postId: Int                 // Post Id(주소)
    let blogId: Int                 // Post가 게시된 Blog Id(주소)
        
    var homeTopicId: Int?            // Post의 홈토픽 Id
    var categoryId: Int?             // Post가 블로그 내에 속한 카테고리 Id (카테고리 미제작 시 불필요)
        
    var title: String               // Post 제목
    var content: [String]           // Post 내용 TODO: 추후 HTML로 표시 및 저장 가능하도록 타입 지정
    var createdAt: Date             // 발행일
    var mainImageUrl: String?        // Post 대표이미지 URL
    
    var commentIds: [Int]           // Post에 있는 commentId List
    var likedUserIds: [Int]         // Post를 좋아요 한 UserId List
}

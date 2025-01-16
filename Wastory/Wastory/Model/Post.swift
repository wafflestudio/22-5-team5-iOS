//
//  Post.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Post: Codable, Identifiable, Hashable {
    let id: Int                    // Post Id(주소)
    let blogID: Int                // Post가 게시된 Blog Id(주소)
        
    var homeTopicID: Int?          // Post의 홈토픽 Id
    var categoryID: Int?           // Post가 블로그 내에 속한 카테고리 Id (카테고리 미제작 시 불필요)
        
    var title: String               // Post 제목
    var description: String?        // Post 미리보기
    var content: String?            // Post 내용 (HTML을 String으로 변환하여 저장)
    var createdAt: Date             // 발행일
    var mainImageUrl: String?       // Post 대표이미지 URL
    var commentCount: Int           // Comment 개수
    var likeCount: Int              // Like 개수
}

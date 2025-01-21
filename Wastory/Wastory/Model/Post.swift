//
//  Post.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Post: Codable, Identifiable, Hashable {
    let id: Int                    // Post Id(주소)
        
    var homeTopicID: Int?          // Post의 홈토픽 Id
    var categoryID: Int?           // Post가 블로그 내에 속한 카테고리 Id (카테고리 미제작 시 불필요)
        
    var title: String               // Post 제목
    var description: String?        // Post 미리보기
    var content: String?            // Post 내용 (HTML을 String으로 변환하여 저장)
    var createdAt: Date             // 발행일
    let blogID: Int                 // Post가 게시된 Blog Id(주소)
    var mainImageUrl: String?       // Post 대표이미지 URL
    var viewCount: Int              // 조회수
    var likeCount: Int              // Like 개수
    var commentCount: Int           // Comment 개수
    
    private enum CodingKeys: String, CodingKey {
        case id
        case homeTopicID
        case categoryID
        case title
        case description
        case content
        case createdAt
        case blogID = "blog_id"
        case mainImageUrl = "main_image_url"
        case viewCount = "views"
        case likeCount = "article_likes"
        case commentCount = "article_comments"
    }
}



import SwiftUI
extension View {
    func tempPost() -> Post {
        Post.init(id: 1, title: "글제목", createdAt: Date(), blogID: 0, viewCount: 555, likeCount: 55, commentCount: 5)
    }
}

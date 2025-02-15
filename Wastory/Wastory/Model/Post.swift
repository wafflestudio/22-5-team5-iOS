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
        
    var title: String               // Post 제목
    var content: String?            // Post 내용 (SwiftData를 String으로 변환하여 저장)
    var description: String?        // Post 미리보기
    var createdAt: Date             // 발행일
    let blogID: Int                 // Post가 게시된 Blog Id(주소)
    var blogName: String?           // Blog 이름
    var blogMainImageURL: String?   // Blog 대표이미지 URL
    var mainImageURL: String?       // Post 대표이미지 URL
    var categoryID: Int?            // Post가 블로그 내에 속한 카테고리 Id
    var viewCount: Int              // 조회수
    var likeCount: Int              // Like 개수
    var commentCount: Int           // Comment 개수
    
    var protected: Int              // 공개글 0 | 보호글 1
    var secret: Int?                // 공개글 0 | 비밀글 1
    var commentsEnabled: Int?       // 댓글 허용 1 | 댓글 불가 0
    
    var password: String?           // 보호 시 비밀번호
    
    private enum CodingKeys: String, CodingKey {
        case id
        case homeTopicID = "hometopic_id"
        case title
        case content
        case description
        case createdAt = "created_at"
        case blogID = "blog_id"
        case blogName = "blog_name"
        case blogMainImageURL = "blog_main_image_url"
        case mainImageURL = "article_main_image_url"
        case categoryID = "category_id"
        case viewCount = "views"
        case likeCount = "article_likes"
        case commentCount = "article_comments"
        case protected
        case secret
        case commentsEnabled = "comments_enabled"
        case password
    }
    
    static let defaultPost: Post = {
        Post(id: 0, title: "", createdAt: Date(timeIntervalSince1970: 1704067200), blogID: 0, viewCount: 0, likeCount: 0, commentCount: 0, protected: 0)
        }()
}

struct PostListDto: Codable {
    let page: Int
    let perPage: Int
    let totalCount: Int
    let articles: [Post]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalCount = "total_count"
        case articles
    }
    
    static let defaultPostListDto: PostListDto = {
        PostListDto(page: 0, perPage: 0, totalCount: 0, articles: [])
    }()
}

struct ArticleDto: Codable {
    let title: String
    let content: String
    let description: String
    let mainImageURL: String
    let categoryID: Int
    let homeTopicID: Int
    let secret: Int
    let protected: Int
    let password: String
    let images: [FileURLDto]
    let commentsEnabled: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case content
        case description
        case mainImageURL = "main_image_url"
        case categoryID = "category_id"
        case homeTopicID = "hometopic_id"
        case secret
        case protected
        case password
        case images
        case commentsEnabled = "comments_enabled"
    }
}

struct FileURLDto: Codable {
    let fileURL: String
    
    private enum CodingKeys: String, CodingKey {
        case fileURL = "file_url"
    }
}


import SwiftUI
extension View {
    func tempPost() -> Post {
        Post.init(id: 4, title: "글제목", createdAt: Date(), blogID: 0, viewCount: 555, likeCount: 55, commentCount: 5, protected: 0)
    }
}

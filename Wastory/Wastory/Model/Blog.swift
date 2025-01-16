//
//  Blog.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Blog: Codable, Identifiable, Hashable {
    let id: UUID                    // Blog Id(주소)
    let userID: UUID                // Blog를 소유한 User Id
         
    var blogName: String            // Blog 이름 (default : "User.username 님의 블로그")
    var mainImageURL: String?       // Blog 대표이미지 URL
    var description: String         // Blog 소개글
}

struct BlogDto: Codable {
    let blogID: Int
    let blogName: String
    let addressName: String
    let description: String
    let createdAt: String
    let updatedAt: String
    let mainImageURL: String?
    let userID: Int
    
    private enum CodingKeys: String, CodingKey {
        case blogID = "id"
        case blogName = "blog_name"
        case addressName = "address_name"
        case description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mainImageURL = "main_image_url"
        case userID = "user_id"
    }
}

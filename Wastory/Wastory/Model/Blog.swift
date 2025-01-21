//
//  Blog.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Blog: Codable, Identifiable, Hashable {
    let id: Int                    // Blog Id(주소)
    var blogName: String            // Blog 이름 (default : "User.username 님의 블로그")
    let addressName: String         // Blog 주소
    var description: String         // Blog 소개글
         
    var mainImageURL: String?       // Blog 대표이미지 URL
    
    let userID: Int                // Blog를 소유한 User Id
    
    private enum CodingKeys: String, CodingKey {
        case id
        case blogName = "blog_name"
        case addressName = "address_name"
        case description
        case mainImageURL = "main_image_url"
        case userID = "user_id"
    }
}

import SwiftUI
extension View {
    func tempBlog() -> Blog {
        Blog.init(id: 0, blogName: "블로그 이름", addressName: "WaSans", description: "블로그 설명어어어어엉엉", userID: 0)
    }
}


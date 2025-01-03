//
//  Blog.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct Blog: Codable {
    let blogId: Int                 // Blog Id(주소)
    let userId: Int                 // Blog를 소유한 User Id
         
    var blogName: String            // Blog 이름 (default : "User.username 님의 블로그")
    var postIds: [Int]              // 블로그에 있는 PostId List
    var mainImageURL: String        // Blog 대표이미지 URL
    var description: String         // Blog 소개글
}

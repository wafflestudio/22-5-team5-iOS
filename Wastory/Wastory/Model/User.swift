//
//  User.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct User: Codable {
    let userID: String               // 이메일 주소
    var password: String             // 비밀번호
    var username: String             // 유저네임
    
    let blogID: UUID                 // 블로그 주소
    var subscribedBlogIDs: [UUID]    // 구독중인 블로그 주소 List
    var subscriberBlogIDs: [UUID]    // 구독자 블로그 주소 List
    
    private enum CodingKeys: String, CodingKey {
        case userID = "email"
        case password
        case username
        case blogID
        case subscribedBlogIDs
        case subscriberBlogIDs
    }
}

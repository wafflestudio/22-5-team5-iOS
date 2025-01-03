//
//  User.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct User: Codable {
    
    let userId: String              // userID
    let email: String               // 이메일 주소
    var password: String            // 비밀번호
    var username: String            // 유저네임
    
    let blogId: Int                 // 블로그 주소
    var subscribedBlogIds: [Int]    // 구독중인 블로그 주소 List
    var subscriberBlogIds: [Int]    // 구독자 블로그 주소 List
    
}

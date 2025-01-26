//
//  User.swift
//  Wastory
//
//  Created by 중워니 on 1/3/25.
//

import Foundation

struct User: Codable {
    var username: String           // 유저네임
    let email: String              // 이메일 주소
    let isKakaoUser: Bool          // 카카오 유저 유무
    
    private enum CodingKeys: String, CodingKey {
        case username
        case email
        case isKakaoUser = "is_kakao_user"
    }
}

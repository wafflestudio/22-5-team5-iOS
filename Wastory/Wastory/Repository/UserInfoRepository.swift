//
//  UserInfoRepository.swift
//  Wastory
//
//  Created by mujigae on 12/29/24.
//

import Observation

@Observable
final class UserInfoRepository {
    static let shared = UserInfoRepository()    // 싱글톤 인스턴스
    
    private var userID = ""     // 아이디
    private var userPW = ""     // 비밀번호
    private var username = ""   // 닉네임 (블로그 주소 대체)
    
    func setUserID(userID: String) {        // 회원가입 시 이용
        self.userID = userID
    }
    
    func setUserPW(userPW: String) {        // 회원가입 시 이용
        self.userPW = userPW
    }
    
    func setUsername(username: String) {    // 회원가입 시 이용
        self.username = username
    }
    
    func loadUserInfo(userID: String, userPW: String) { // 로그인 시 이용
        self.userID = userID
        self.userPW = userPW
        // DB에서 유저 닉네임 정보 및 추후 추가될 다른 정보를 불러오는 코드 필요
        self.username = "example"
    }
    
    func getUserID() -> String {
        return userID
    }
    
    func getUserPW() -> String {
        return userPW
    }
    
    func getUserName() -> String {
        return username
    }
}

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
    
    private var userActive: Bool = false        // 유저의 상태: 로그인 (true) | 로그아웃 (false)
    
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
    
    func setUserInfo() {                    // 회원가입 시 이용
        // DB에 ID, PW, username을 연동하여 저장하는 기능 구현 필요
        // 해당 함수가 실행될 때는 이미 userID, userPW, username이 모두 empty string이 아니어야 함 (회원가입을 진행했기 때문에)
        self.userActive = true
    }
    
    func loadUserInfo(userID: String, userPW: String) { // 로그인 시 이용
        self.userID = userID
        self.userPW = userPW
        // 로그인 성공 여부를 판단하고 DB에서 유저 닉네임 정보 및 추후 추가될 다른 정보를 불러오는 코드 필요
        if self.userID.isEmpty == false {    // 테스트를 위한 임시 코드 (추후 DB와 연결 필요)
            self.userActive = true
        }
    }
    
    func isUserActive() -> Bool {
        return userActive
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

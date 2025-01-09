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
    
    private var userID = ""         // 아이디
    private var userPW = ""         // 비밀번호
    private var addressName = ""    // 블로그 주소 식별자
    
    private var username = ""       // 닉네임
    
    // 서버 통신용 임시 코드 (username이랑 추후 정리 필요)
    var needAddressName: Bool = false
    func isAddressNameNeeded() -> Bool {
        return needAddressName
    }
    
    func setUserID(userID: String) {        // 회원가입 시 이용
        self.userID = userID
    }
    func setUserPW(userPW: String) {        // 회원가입 시 이용
        self.userPW = userPW
    }
    func setAddressName(addressName: String) {    // 회원가입 시 이용
        self.addressName = addressName
    }
    
    func setUserInfo() {                    // 회원가입 시 이용
        // DB에 ID, PW, username을 연동하여 저장하는 기능 구현 필요
        // 해당 함수가 실행될 때는 이미 userID, userPW, addressName이 모두 empty string이 아니어야 함 (회원가입을 진행했기 때문에)
        self.userActive = true
    }
    
    func loadUserInfo(userID: String, userPW: String) async { // 로그인 시 이용
        self.userID = userID
        self.userPW = userPW
        // 로그인 성공 여부를 판단하고 DB에서 유저 닉네임 정보 및 추후 추가될 다른 정보를 불러오는 코드 필요
        do {
            let response = try await NetworkRepository.shared.postSignIn(
                userID: self.userID,
                userPW: self.userPW
            )
            if !response.access_token.isEmpty {
                print("로그인 성공")  // 테스트용 임시 콘솔 메세지
                NetworkConfiguration.accessToken = response.access_token
                NetworkConfiguration.refreshToken = response.refresh_token
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        do {
            let response = try await NetworkRepository.shared.getMyBlog()
            addressName = response.address_name
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        if addressName.isEmpty {
            needAddressName = true
        }
        else {
            userActive = true
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
    func getAddressName() -> String {
        return addressName
    }
    func getUserName() -> String {
        return username
    }
}

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
    private var blogName = ""       // 블로그 이름
    private var username = ""       // 닉네임
    
    private var blogID = 0          // 임시로 만든 API를 위한 블로그 아이디
    func setBlogID(blogID: Int) {
        self.blogID = blogID
    }
    func getBlogID() -> Int {
        return blogID
    }
    
    // 최초로 블로그를 개설했는지 App이 판단하기 위한 변수
    var needAddressName: Bool = false
    func isAddressNameNeeded() -> Bool {
        return needAddressName
    }
    
    func setUserID(userID: String) {    // 회원가입에서만 이용
        self.userID = userID
    }
    func setUserPW(userPW: String) {
        self.userPW = userPW
    }
    func setAddressName(addressName: String) {
        self.addressName = addressName
    }
    func setBlogName(blogName: String) {
        self.blogName = blogName
    }
    func setUsername(username: String) {
        self.username = username
    }
    
    func setUserInfo() {    // 블로그 주소를 설정했을 때 이용
        // 해당 함수가 실행될 때는 이미 userID, userPW, addressName이 모두 empty string이 아니어야 함 (회원가입을 진행했기 때문에)
        Task {
            self.blogName = addressName + "님의 블로그"
            self.username = addressName
            await loadUserInfo(userID: self.userID, userPW: self.userPW)
        }
    }
    
    func loadUserInfo(userID: String, userPW: String) async {   // 로그인 시 이용
        self.userID = userID
        self.userPW = userPW
        
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
            addressName = response.addressName
            blogName = response.blogName
            blogID = response.id
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
    
    func resetUserInfo() {
        userID = ""
        userPW = ""
        addressName = ""
        blogName = ""
        blogID = 0
        username = ""
        needAddressName = false
        userActive = false
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
    func getBlogName() -> String {
        return blogName
    }
    func getUsername() -> String {
        return username
    }
    
    
    func patchUsername(to name: String) {
        username = name
    }
}

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
    
    // MARK: User
    private var userID = ""             // 아이디
    private var userPW = ""             // 비밀번호
    private var isKakaoLogin = false    // 카카오 로그인 유저 식별
    
    // MARK: Blog
    private var addressName = ""        // 블로그 주소 식별자
    private var blogName = ""           // 블로그 이름
    private var blogID = 0              // 블로그 아이디
    private var username = ""           // 닉네임 (원래는 닉네임이 블로그에 종속되는 항목이지만 블로그가 1개로 제한됨에 따라 수정할 여지 존재)
    
    
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
    func setBlogID(blogID: Int) {
        self.blogID = blogID
    }
    func setUsername(username: String) {
        self.username = username
    }
    
    func setUserInfo() {    // 블로그 주소를 설정했을 때 이용
        // 해당 함수가 실행될 때는 이미 userID, userPW, addressName이 모두 empty string이 아니어야 함 (회원가입을 진행했기 때문에)
        Task {
            if isKakaoLogin {
                await loadKakaoUserInfo()
            }
            else {
                await loadUserInfo(userID: self.userID, userPW: self.userPW)
            }
        }
    }
    
    // MARK: - 일반 유저 회원가입 및 로그인
    func loadUserInfo(userID: String, userPW: String) async {
        self.userID = userID
        self.userPW = userPW
        
        do {
            let response = try await NetworkRepository.shared.postSignIn(
                userID: self.userID,
                userPW: self.userPW
            )
            NetworkConfiguration.accessToken = response.access_token
            NetworkConfiguration.refreshToken = response.refresh_token
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        // MARK: Set User Information
        do {
            let response = try await NetworkRepository.shared.getMe()
            self.username = response.username ?? ""
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        // MARK: Set Blog Information
        do {
            let response = try await NetworkRepository.shared.getMyBlog()
            self.addressName = response.addressName
            self.blogName = response.blogName
            self.blogID = response.id
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        // MARK: 블로그 주소 설정 여부 확인
        if self.addressName.isEmpty {
            self.needAddressName = true
        }
        else {
            self.userActive = true
        }
    }
    
    // MARK: - 카카오 유저 로그인
    func loadKakaoUserInfo() async {
        // MARK: Set User Information
        do {
            let response = try await NetworkRepository.shared.getMe()
            self.userID = response.username ?? ""
            self.isKakaoLogin = true
            self.username = response.username ?? ""
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        // MARK: Set Blog Information
        do {
            let response = try await NetworkRepository.shared.getMyBlog()
            self.addressName = response.addressName
            self.blogName = response.blogName
            self.blogID = response.id
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        // MARK: 블로그 주소 설정 여부 확인
        if self.addressName.isEmpty {
            self.needAddressName = true
        }
        else {
            self.userActive = true
        }
    }
    
    // MARK: 로그아웃 또는 탈퇴
    func resetUserInfo() {
        self.userID = ""
        self.userPW = ""
        
        self.addressName = ""
        self.blogName = ""
        self.blogID = 0
        self.username = ""
        
        self.needAddressName = false
        self.userActive = false
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
    func checkKaKaoLogin() -> Bool {
        return isKakaoLogin
    }
    func getAddressName() -> String {
        return addressName
    }
    func getBlogName() -> String {
        return blogName
    }
    func getBlogID() -> Int {
        return blogID
    }
    func getUsername() -> String {
        return username
    }
    
    
    func patchUsername(to name: String) {
        username = name
    }
}

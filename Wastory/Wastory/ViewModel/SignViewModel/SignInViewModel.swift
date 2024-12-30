//
//  SignInViewModel.swift
//  Wastory
//
//  Created by mujigae on 12/26/24.
//

import SwiftUI
import Observation

@Observable final class SignInViewModel {
    @AppStorage("userID") @ObservationIgnored private var userID: String = ""
    @AppStorage("userPW") @ObservationIgnored private var userPW: String = ""
    @AppStorage("loginAutoSave") @ObservationIgnored private var loginInfoSave: Bool = false
    
    private var userInfoRepository = UserInfoRepository.shared
    
    var id = ""
    var password = ""
    private var isLoginInfoSave = false
    private var isPasswordInvisible: Bool = true
    private var loginFailed = false
    
    init() {
        id = userID
        isLoginInfoSave = loginInfoSave
    }
    
    func login() {
        // DB와 통신하여 로그인 성공 여부를 판단하는 기능 필요
        
        loginInfoSave = isLoginInfoSave
        if loginInfoSave {
            userID = id
            userPW = password
        }
        else {
            userID = ""
            userPW = ""
        }
        userInfoRepository.loadUserInfo(userID: userID, userPW: userPW)
    }
    
    func isLoginFailed() -> Bool {
        return loginFailed
    }
    
    func toggleLoginFailed() {  // 로그인 실패 문구를 확인하기 위한 임시 함수 (추후 삭제 예정)
        loginFailed.toggle()
    }
    
    func toggleAutoSave() {
        isLoginInfoSave.toggle()
    }
    
    func isInfoSaveOn() -> Bool {
        return isLoginInfoSave
    }
    
    func clearIdTextField() {
        id = ""
    }
    
    func isClearButtonInactive() -> Bool {
        return id.isEmpty
    }
    
    func togglePasswordVisibility() {
        isPasswordInvisible.toggle()
    }
    
    func isPasswordVisible() -> Bool {
        return !isPasswordInvisible
    }
    
    func isEyeButtonInactive() -> Bool {
        return password.isEmpty
    }
}

//
//  SignUpStep5ViewModel.swift
//  Wastory
//
//  Created by mujigae on 12/27/24.
//

import SwiftUI
import Observation

@Observable final class SignUpStep5ViewModel {
    var username = "example"
    var blogAddress = "example.waffle.com"
    var usernameAvailability = "사용할 수 없어요."
    
    func setUsername() {
        UserInfoRepository.shared.setUsername(username: username)
    }
    
    func setBlogAddress() {
        blogAddress = username + ".waffle.com"
    }
    
    func setUserInfo() {
        UserInfoRepository.shared.setUserInfo()
    }
    
    func checkUsernameAvailability() {
        if username.isEmpty {
            usernameAvailability = "사용할 수 없어요."
        }
        else {
            usernameAvailability = "👏 세상에 하나뿐인 주소에요!"
        }
    }
    
    func clearIdTextField() {
        username = ""
    }
    
    func isClearButtonInactive() -> Bool {
        return username.isEmpty
    }
}

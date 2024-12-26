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
    @AppStorage("loginAutoSave") @ObservationIgnored private var loginAutoSave: Bool = false
    
    var id = ""
    var password = ""
    private var loginAutoSaveOn = false
    private var isPasswordInvisible: Bool = true
    
    init() {
        id = userID
        loginAutoSaveOn = loginAutoSave
    }
    
    func login() {
        if loginAutoSave {
            userID = id
            userPW = password
        }
        else {
            userID = ""
            userPW = ""
        }
        loginAutoSave = loginAutoSaveOn
    }
    
    func toggleAutoSave() {
        loginAutoSaveOn = !loginAutoSaveOn
    }
    
    func isAutoSaveOn() -> Bool {
        return loginAutoSaveOn
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

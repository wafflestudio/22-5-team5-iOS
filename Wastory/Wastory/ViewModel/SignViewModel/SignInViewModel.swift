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
}

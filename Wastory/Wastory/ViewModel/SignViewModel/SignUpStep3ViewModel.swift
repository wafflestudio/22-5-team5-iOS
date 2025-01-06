//
//  SignUpStep3ViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/2/25.
//

import SwiftUI
import Observation

@Observable final class SignUpStep3ViewModel {
    var password: String = ""
    var password2: String = ""
    
    // MARK: 비밀번호 - password
    func clearPasswordTextField() {
        password = ""
    }
    
    func isClearPasswordButtonInactive() -> Bool {
        return password.isEmpty
    }
    
    // MARK: 점검용 비밀번호 - password2
    func clearPassword2TextField() {
        password2 = ""
    }
    
    func isClearPassword2ButtonInactive() -> Bool {
        return password2.isEmpty
    }
}

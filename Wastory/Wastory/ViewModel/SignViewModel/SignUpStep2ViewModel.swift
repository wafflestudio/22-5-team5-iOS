//
//  SignUpStep2ViewModel.swift
//  Wastory
//
//  Created by mujigae on 12/30/24.
//

import SwiftUI
import Observation

@Observable final class SignUpStep2ViewModel {
    var email: String = ""
    var code: String = ""
    
    private var isCodeRequested: Bool = false
    private var emptyEmailRequested: Bool = false
    
    private let codeLength: Int = 8
    
    func clearEmailTextField() {
        email = ""
    }
    
    func isClearEmailButtonInactive() -> Bool {
        return email.isEmpty
    }
    
    func requestCode() {
        if email.isEmpty == false {
            isCodeRequested = true
            emptyEmailRequested = false
            // 이메일 인증번호 보내는 기능 필요
        }
        else {
            emptyEmailRequested = true
        }
    }
    
    func isEmptyEmailRequested() -> Bool {
        return emptyEmailRequested
    }
    
    func isCodeRequired() -> Bool {
        return isCodeRequested
    }
    
    func clearCodeTextField() {
        code = ""
    }
    
    func isClearCodeButtonInactive() -> Bool {
        return code.isEmpty
    }
    
    func isCodeEntered() -> Bool {
        return code.count == codeLength
    }
}

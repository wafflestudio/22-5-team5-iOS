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
    private var invalidEmailRequested: Bool = false
    
    private let codeLength: Int = 8
    private var emptyCodeEntered: Bool = false
    private var invalidCodeEntered: Bool = false
    
    func requestEmailReentry() {
        // 이메일 입력화면으로 되돌아가는 버튼
        email = ""
        code = ""
        isCodeRequested = false
        emptyEmailRequested = false
        invalidEmailRequested = false
        emptyCodeEntered = false
        invalidCodeEntered = false
    }
    
    // MARK: Email TextField
    func clearEmailTextField() {
        email = ""
    }
    
    func isClearEmailButtonInactive() -> Bool {
        return email.isEmpty
    }
    
    func requestCode() {
        if email.isEmpty {
            invalidEmailRequested = false
            emptyEmailRequested = true
        }
        else if isValidEmail(email) {
            isCodeRequested = true
            emptyEmailRequested = false
            invalidEmailRequested = false
        }
        else {
            emptyEmailRequested = false
            invalidEmailRequested = true
        }
    }
    
    func isEmptyEmailRequested() -> Bool {
        return emptyEmailRequested
    }
    
    func isInvalidEmailRequested() -> Bool {
        return invalidEmailRequested
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: Verification Code TextField
    func isCodeRequired() -> Bool {
        return isCodeRequested
    }
    
    func clearCodeTextField() {
        code = ""
    }
    
    func isClearCodeButtonInactive() -> Bool {
        return code.isEmpty
    }
    
    func isEmptyCodeEntered() -> Bool {
        return emptyCodeEntered
    }
    
    func isInvalidCodeEntered() -> Bool {
        return invalidCodeEntered
    }
    
    func checkCodeValidty(_ code: String) {
        if code.isEmpty {
            invalidCodeEntered = false
        }
        else {
            emptyCodeEntered = false
            invalidCodeEntered = !code.allSatisfy { $0.isNumber } || code.count < 8
        }
    }
    
    func isVerificationSuccessful() -> Bool {
        // 인증코드 유효성 검사 코드 필요
        if code.isEmpty {
            emptyCodeEntered = true
            return false
        }
        return !code.isEmpty && !invalidCodeEntered
    }
}

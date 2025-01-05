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
    
    func isCodeEntered() -> Bool {
        return code.count == codeLength
    }
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

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
    private var touchedEmailScreen: Bool = false
    private var tappedNextButton: Bool = false
    
    private let codeLength: Int = 8
    private var emptyCodeEntered: Bool = false
    private var invalidCodeEntered: Bool = false
    
    func requestEmailReentry() {
        // 이메일 입력화면으로 되돌아가는 버튼
        email = ""
        code = ""
        isCodeRequested = false
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
        if isEmailValid(email) {
            isCodeRequested = true
        }
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func emailValidator() -> String {
        if tappedNextButton {
            return "인증요청을 먼저 진행해 주세요."
        }
        if email.isEmpty {
            return "와스토리 계정 이메일을 입력해 주세요."
        }
        if isEmailValid(email) == false {
            return "와스토리 계정 이메일 형식이 올바르지 않습니다."
        }
        return ""
    }
    
    func touchEmailScreen() {
        touchedEmailScreen = true
    }
    func isEmailScreenTouched() -> Bool {
        return touchedEmailScreen
    }
    
    func tapNextButton() {
        tappedNextButton = true
    }
    func untapNextButton() {
        tappedNextButton = false
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

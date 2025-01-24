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
    var emailExists: Bool = false
    var code: String = ""
    
    private var isCodeRequested: Bool = false
    private var touchedEmailScreen: Bool = false
    private var tappedNextButton: Bool = false
    
    private let codeLength: Int = 8
    private var touchedCodeScreen: Bool = false
    
    func getCodeLength() -> Int {
        return codeLength
    }
    
    func requestEmailReentry() {
        // 이메일 입력화면으로 되돌아가는 버튼
        email = ""
        code = ""
        isCodeRequested = false
    }
    
    // MARK: Email TextField
    func clearEmailTextField() {
        email = ""
    }
    func isClearEmailButtonInactive() -> Bool {
        return email.isEmpty
    }
    
    func requestCode() async {
        if isEmailValid() {
            // 이메일 중복 검사
            do {
                emailExists = try await NetworkRepository.shared.postEmailExists(email: email)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
            if emailExists { return }
            
            // 이메일 인증 코드 발송
            do {
                try await NetworkRepository.shared.postRequestVerification(email: email)
                isCodeRequested = true
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func toggleEmailExists() {
        emailExists.toggle()
    }
    
    func isEmailValid() -> Bool {
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
        if isEmailValid() == false {
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
    
    func codeValidator() -> String {
        if code.isEmpty {
            return "이메일로 발송된 인증번호를 입력해 주세요."
        }
        if !code.allSatisfy({ $0.isNumber }) || code.count < codeLength {
            return "인증번호 형식이 올바르지 않습니다."
        }
        return ""
    }
    
    func isCodeValid() -> Bool {
        // 인증코드 유효성 검사 코드 필요
        return true
    }
    
    func isVerificationSuccessful() -> Bool {
        return !code.isEmpty && codeValidator().isEmpty && isCodeValid()
    }
    
    func touchCodeScreen() {
        touchedCodeScreen = true
    }
    func isCodeScreenTouched() -> Bool {
        return touchedCodeScreen
    }
}

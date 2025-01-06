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
    
    func passwordValidator() -> String {
        // 1. 비밀번호가 비어 있는 경우
        if password.isEmpty {
            return "와스토리 계정 비밀번호를 입력해 주세요.(영문자/숫자/특수문자)"
        }
        
        // 2. 비밀번호 길이가 범위를 벗어난 경우
        if password.count < 8 || password.count > 32 {
            return "비밀번호는 8~32자리(영문자/숫자/특수문자)로 입력할 수 있어요."
        }
        
        // 3. 사용할 수 없는 문자가 포함된 경우
        let forbiddenCharactersRegex = "[^A-Za-z\\d!@#$%^&*()_+\\-=\\[\\]{}|;:',.<>?/`~]"
        if NSPredicate(format: "SELF MATCHES %@", forbiddenCharactersRegex).evaluate(with: password) {
            return "영문자, 숫자, 특수문자만 비밀번호에 입력해 주세요."
        }

        // 4. 숫자만 사용한 경우
        let numberOnlyRegex = "^[0-9]+$"
        if NSPredicate(format: "SELF MATCHES %@", numberOnlyRegex).evaluate(with: password) {
            return "영문자, 특수문자를 함께 입력해 주세요."
        }

        // 5. 영어만 사용한 경우
        let lettersOnlyRegex = "^[A-Za-z]+$"
        if NSPredicate(format: "SELF MATCHES %@", lettersOnlyRegex).evaluate(with: password) {
            return "숫자, 특수문자를 함께 입력해 주세요."
        }

        // 6. 특수문자만 사용한 경우
        let specialCharactersOnlyRegex = "^[!@#$%^&*()_+\\-=\\[\\]{}|;:',.<>?/`~]+$"
        if NSPredicate(format: "SELF MATCHES %@", specialCharactersOnlyRegex).evaluate(with: password) {
            return "영문자, 숫자를 함께 입력해 주세요."
        }

        // 7. 유효한 비밀번호
        return ""
    }
    
    // MARK: 점검용 비밀번호 - password2
    func clearPassword2TextField() {
        password2 = ""
    }
    func isClearPassword2ButtonInactive() -> Bool {
        return password2.isEmpty
    }
    
    func isEqualPassword() -> Bool {
        return password == password2
    }
}

//
//  PasswordSettingViewModel.swift
//  Wastory
//
//  Created by mujigae on 1/21/25.
//

import SwiftUI
import Observation

@Observable final class PasswordSettingViewModel {
    @AppStorage("userPW") @ObservationIgnored private var userPW: String = ""
    
    var password0: String = ""
    var password: String = ""
    var password2: String = ""
    
    var isPasswordSecureFieldRendered: Bool = false
    var isPasswordFieldTapped: Bool = false
    var isNavigationActive: Bool = false
    var activeAlert: PasswordSettingAlertType?
    
    let forbiddenCharactersRegex = "[^A-Za-z\\d!@#$%^&*()_+\\-=\\[\\]{}|;:',.<>?/`~]"
    let numberOnlyRegex = "^[0-9]+$"
    let lettersOnlyRegex = "^[A-Za-z]+$"
    let specialCharactersOnlyRegex = "^[!@#$%^&*()_+\\-=\\[\\]{}|;:',.<>?/`~]+$"
    
    // MARK: 기존 비밀번호 - password0
    func clearPassword0TextField() {
        password0 = ""
    }
    func isClearPassword0ButtonInactive() -> Bool {
        return password0.isEmpty
    }
    
    func password0Validator() -> String {
        // 1. 비밀번호가 비어 있는 경우
        if password0.isEmpty {
            return "기존 비밀번호를 입력해 주세요.(영문자/숫자/특수문자)"
        }
        
        // 2. 비밀번호 길이가 범위를 벗어난 경우
        if password0.count < 8 || password0.count > 32
            || NSPredicate(format: "SELF MATCHES %@", forbiddenCharactersRegex).evaluate(with: password0)
            || NSPredicate(format: "SELF MATCHES %@", numberOnlyRegex).evaluate(with: password0)
            || NSPredicate(format: "SELF MATCHES %@", lettersOnlyRegex).evaluate(with: password0)
            || NSPredicate(format: "SELF MATCHES %@", specialCharactersOnlyRegex).evaluate(with: password0) {
            return "비밀번호 형식이 잘못되었습니다."
        }
        
        // 3. 유효한 비밀번호
        return ""
    }
    
    // MARK: 새로운 비밀번호 - password
    func clearPasswordTextField() {
        password = ""
    }
    func isClearPasswordButtonInactive() -> Bool {
        return password.isEmpty
    }
    
    func passwordValidator() -> String {
        // 1. 비밀번호가 비어 있는 경우
        if password.isEmpty {
            return "새로운 비밀번호를 입력해 주세요.(영문자/숫자/특수문자)"
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
    
    func isPasswordValid() -> Bool {
        return passwordValidator().isEmpty && password == password2
    }
    
    func updatePassword() async -> Int {
        do {
            let response = try await NetworkRepository.shared.postSignIn(
                userID: UserInfoRepository.shared.getUserID(),
                userPW: self.password0
            )
            NetworkConfiguration.accessToken = response.access_token
            NetworkConfiguration.refreshToken = response.refresh_token
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return 0
        }
        if password0 == password { return 1 }
        do {
            try await NetworkRepository.shared.patchPassword(
                oldPW: password0,
                newPW: password)
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return 3    // Network Error
        }
        UserInfoRepository.shared.setUserPW(userPW: self.password)
        userPW = ""
        return 2
    }
}

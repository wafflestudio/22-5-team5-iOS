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
    
    private let codeLength: Int = 6
    
    func clearEmailTextField() {
        email = ""
    }
    
    func isClearEmailButtonInactive() -> Bool {
        return email.isEmpty
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
